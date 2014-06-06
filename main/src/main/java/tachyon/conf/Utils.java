/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package tachyon.conf;

import org.apache.log4j.Logger;

import tachyon.util.CommonUtils;

/**
 * Utils for tachyon.conf package.
 */
class Utils {
  UtilsBase mConf = null;
  
  public Utils(){
    if (mConf == null){
      mConf = new UtilsOpt();
    }
  }

  public Utils(String name){
    if (mConf == null){
      mConf = new UtilsFile(name);
    }
  }

  public void addResource(String name){
    mConf = new UtilsFile(name);
  }
  
  private final Logger LOG = Logger.getLogger("");

  public boolean getBooleanProperty(String property) {
    return mConf.getBooleanProperty(property);
  }

  public boolean getBooleanProperty(String property, boolean defaultValue) {
    return mConf.getBooleanProperty(property, defaultValue);
  }

  public int getIntProperty(String property) {
    return mConf.getIntProperty(property);
  }

  public int getIntProperty(String property, int defaultValue) {
    return mConf.getIntProperty(property, defaultValue);
  }

  public long getLongProperty(String property) {
    return mConf.getLongProperty(property);
  }

  public long getLongProperty(String property, int defaultValue) {
    return mConf.getLongProperty(property, defaultValue);
  }

  public String getProperty(String property) {
    return mConf.getProperty(property);
  }

  public String getProperty(String property, String defaultValue) {
    return mConf.getProperty(property, defaultValue);
  }

}