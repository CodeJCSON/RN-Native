/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TouchableOpacity,
    NativeModules
} from 'react-native';
var RNBridgeModule=NativeModules.RNViewController;
import { NativeAppEventEmitter } from 'react-native';
var subscription; //订阅者

class myproject extends Component {
    constructor(props){
        super(props);
        this.state={
            events:'',
            msg:'',
        }
    }

    // 获取Promise对象处理
    async press(){
        try{
            // 回调成功
            var events=await RNBridgeModule.RNInvokeOCPromise({'name':'nihao'});
            this.setState({events:events});
        }catch(e){
            // 回调失败
            this.setState({events:'😁哈'});
        }
    }
    render() {
        return (
            <View style={{marginTop:20}}>

                <Text style={{margin:5}}>'返回数据为:'+{this.state.events}</Text>
                <TouchableOpacity onPress={()=>{RNBridgeModule.RNInvokeOCCallBack(
                    {'name':'大话','lalal':'http://www.lcode.org'},
                    (err, event)=>{
                        if (err){
                            console.log(err);
                        }else {
                            this.setState({events:event});
                        }
                    }
                )}}
                  >
                    <Text>大家好</Text>
                </TouchableOpacity>
                <TouchableOpacity onPress={()=>{
                    this.press()
                }}


                >
                    <Text>大家好</Text>
                </TouchableOpacity>

            </View>
        );
    }
    componentDidMount(){
        console.log('原生开始发送通知...');
        subscription = NativeAppEventEmitter.addListener(
            'EventReminder',
            (reminder) => {
                let errorCode=reminder.errorCode;
                if(errorCode===0){
                    this.setState({events:reminder.msg});
                }else{
                    this.setState({events:reminder.msg});
                }

            }
        );
    }
    componentWillUnmount(){
        subscription.remove();
    }
}

const styles = StyleSheet.create({
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    button: {
        margin:5,
        backgroundColor: 'white',
        padding: 10,
        borderWidth: 1,
        borderColor: '#facece',
    },
});

AppRegistry.registerComponent('myproject', () => myproject);
