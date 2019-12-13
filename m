Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B33C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DE22465E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbfLMB7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:59:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbfLMB7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:59:02 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 851E678041BB411D4832;
        Fri, 13 Dec 2019 09:58:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 13 Dec 2019 09:58:54 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [-next] hwmon: (w83627ehf) make sensor_dev_attr_##_name variables static
Date:   Fri, 13 Dec 2019 09:56:05 +0800
Message-ID: <20191213015605.172472-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/hwmon/w83627ehf.c:1202:1: warning: symbol 'sensor_dev_attr_pwm1_target' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1204:1: warning: symbol 'sensor_dev_attr_pwm2_target' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1206:1: warning: symbol 'sensor_dev_attr_pwm3_target' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1208:1: warning: symbol 'sensor_dev_attr_pwm4_target' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1211:1: warning: symbol 'sensor_dev_attr_pwm1_tolerance' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1213:1: warning: symbol 'sensor_dev_attr_pwm2_tolerance' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1215:1: warning: symbol 'sensor_dev_attr_pwm3_tolerance' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1217:1: warning: symbol 'sensor_dev_attr_pwm4_tolerance' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1294:1: warning: symbol 'sensor_dev_attr_pwm4_stop_time' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1296:1: warning: symbol 'sensor_dev_attr_pwm4_start_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1298:1: warning: symbol 'sensor_dev_attr_pwm4_stop_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1300:1: warning: symbol 'sensor_dev_attr_pwm4_max_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1302:1: warning: symbol 'sensor_dev_attr_pwm4_step_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1305:1: warning: symbol 'sensor_dev_attr_pwm3_stop_time' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1307:1: warning: symbol 'sensor_dev_attr_pwm3_start_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1309:1: warning: symbol 'sensor_dev_attr_pwm3_stop_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1312:1: warning: symbol 'sensor_dev_attr_pwm1_stop_time' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1314:1: warning: symbol 'sensor_dev_attr_pwm2_stop_time' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1316:1: warning: symbol 'sensor_dev_attr_pwm1_start_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1318:1: warning: symbol 'sensor_dev_attr_pwm2_start_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1320:1: warning: symbol 'sensor_dev_attr_pwm1_stop_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1322:1: warning: symbol 'sensor_dev_attr_pwm2_stop_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1330:1: warning: symbol 'sensor_dev_attr_pwm1_max_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1332:1: warning: symbol 'sensor_dev_attr_pwm1_step_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1334:1: warning: symbol 'sensor_dev_attr_pwm2_max_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1336:1: warning: symbol 'sensor_dev_attr_pwm2_step_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1338:1: warning: symbol 'sensor_dev_attr_pwm3_max_output' was not declared. Should it be static?
drivers/hwmon/w83627ehf.c:1340:1: warning: symbol 'sensor_dev_attr_pwm3_step_output' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/hwmon/w83627ehf.c | 56 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 207cc74..0a13f6b 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1199,22 +1199,22 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-SENSOR_DEVICE_ATTR(pwm1_target, 0644, show_target_temp,
+static SENSOR_DEVICE_ATTR(pwm1_target, 0644, show_target_temp,
 	    store_target_temp, 0);
-SENSOR_DEVICE_ATTR(pwm2_target, 0644, show_target_temp,
+static SENSOR_DEVICE_ATTR(pwm2_target, 0644, show_target_temp,
 	    store_target_temp, 1);
-SENSOR_DEVICE_ATTR(pwm3_target, 0644, show_target_temp,
+static SENSOR_DEVICE_ATTR(pwm3_target, 0644, show_target_temp,
 	    store_target_temp, 2);
-SENSOR_DEVICE_ATTR(pwm4_target, 0644, show_target_temp,
+static SENSOR_DEVICE_ATTR(pwm4_target, 0644, show_target_temp,
 	    store_target_temp, 3);
 
-SENSOR_DEVICE_ATTR(pwm1_tolerance, 0644, show_tolerance,
+static SENSOR_DEVICE_ATTR(pwm1_tolerance, 0644, show_tolerance,
 	    store_tolerance, 0);
-SENSOR_DEVICE_ATTR(pwm2_tolerance, 0644, show_tolerance,
+static SENSOR_DEVICE_ATTR(pwm2_tolerance, 0644, show_tolerance,
 	    store_tolerance, 1);
-SENSOR_DEVICE_ATTR(pwm3_tolerance, 0644, show_tolerance,
+static SENSOR_DEVICE_ATTR(pwm3_tolerance, 0644, show_tolerance,
 	    store_tolerance, 2);
-SENSOR_DEVICE_ATTR(pwm4_tolerance, 0644, show_tolerance,
+static SENSOR_DEVICE_ATTR(pwm4_tolerance, 0644, show_tolerance,
 	    store_tolerance, 3);
 
 /* Smart Fan registers */
@@ -1291,35 +1291,35 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
 
 fan_time_functions(fan_stop_time, FAN_STOP_TIME)
 
-SENSOR_DEVICE_ATTR(pwm4_stop_time, 0644, show_fan_stop_time,
+static SENSOR_DEVICE_ATTR(pwm4_stop_time, 0644, show_fan_stop_time,
 	    store_fan_stop_time, 3);
-SENSOR_DEVICE_ATTR(pwm4_start_output, 0644, show_fan_start_output,
+static SENSOR_DEVICE_ATTR(pwm4_start_output, 0644, show_fan_start_output,
 	    store_fan_start_output, 3);
-SENSOR_DEVICE_ATTR(pwm4_stop_output, 0644, show_fan_stop_output,
+static SENSOR_DEVICE_ATTR(pwm4_stop_output, 0644, show_fan_stop_output,
 	    store_fan_stop_output, 3);
-SENSOR_DEVICE_ATTR(pwm4_max_output, 0644, show_fan_max_output,
+static SENSOR_DEVICE_ATTR(pwm4_max_output, 0644, show_fan_max_output,
 	    store_fan_max_output, 3);
-SENSOR_DEVICE_ATTR(pwm4_step_output, 0644, show_fan_step_output,
+static SENSOR_DEVICE_ATTR(pwm4_step_output, 0644, show_fan_step_output,
 	    store_fan_step_output, 3);
 
-SENSOR_DEVICE_ATTR(pwm3_stop_time, 0644, show_fan_stop_time,
+static SENSOR_DEVICE_ATTR(pwm3_stop_time, 0644, show_fan_stop_time,
 	    store_fan_stop_time, 2);
-SENSOR_DEVICE_ATTR(pwm3_start_output, 0644, show_fan_start_output,
+static SENSOR_DEVICE_ATTR(pwm3_start_output, 0644, show_fan_start_output,
 	    store_fan_start_output, 2);
-SENSOR_DEVICE_ATTR(pwm3_stop_output, 0644, show_fan_stop_output,
+static SENSOR_DEVICE_ATTR(pwm3_stop_output, 0644, show_fan_stop_output,
 		    store_fan_stop_output, 2);
 
-SENSOR_DEVICE_ATTR(pwm1_stop_time, 0644, show_fan_stop_time,
+static SENSOR_DEVICE_ATTR(pwm1_stop_time, 0644, show_fan_stop_time,
 	    store_fan_stop_time, 0);
-SENSOR_DEVICE_ATTR(pwm2_stop_time, 0644, show_fan_stop_time,
+static SENSOR_DEVICE_ATTR(pwm2_stop_time, 0644, show_fan_stop_time,
 	    store_fan_stop_time, 1);
-SENSOR_DEVICE_ATTR(pwm1_start_output, 0644, show_fan_start_output,
+static SENSOR_DEVICE_ATTR(pwm1_start_output, 0644, show_fan_start_output,
 	    store_fan_start_output, 0);
-SENSOR_DEVICE_ATTR(pwm2_start_output, 0644, show_fan_start_output,
+static SENSOR_DEVICE_ATTR(pwm2_start_output, 0644, show_fan_start_output,
 	    store_fan_start_output, 1);
-SENSOR_DEVICE_ATTR(pwm1_stop_output, 0644, show_fan_stop_output,
+static SENSOR_DEVICE_ATTR(pwm1_stop_output, 0644, show_fan_stop_output,
 	    store_fan_stop_output, 0);
-SENSOR_DEVICE_ATTR(pwm2_stop_output, 0644, show_fan_stop_output,
+static SENSOR_DEVICE_ATTR(pwm2_stop_output, 0644, show_fan_stop_output,
 	    store_fan_stop_output, 1);
 
 
@@ -1327,17 +1327,17 @@ SENSOR_DEVICE_ATTR(pwm2_stop_output, 0644, show_fan_stop_output,
  * pwm1 and pwm3 don't support max and step settings on all chips.
  * Need to check support while generating/removing attribute files.
  */
-SENSOR_DEVICE_ATTR(pwm1_max_output, 0644, show_fan_max_output,
+static SENSOR_DEVICE_ATTR(pwm1_max_output, 0644, show_fan_max_output,
 	    store_fan_max_output, 0);
-SENSOR_DEVICE_ATTR(pwm1_step_output, 0644, show_fan_step_output,
+static SENSOR_DEVICE_ATTR(pwm1_step_output, 0644, show_fan_step_output,
 	    store_fan_step_output, 0);
-SENSOR_DEVICE_ATTR(pwm2_max_output, 0644, show_fan_max_output,
+static SENSOR_DEVICE_ATTR(pwm2_max_output, 0644, show_fan_max_output,
 	    store_fan_max_output, 1);
-SENSOR_DEVICE_ATTR(pwm2_step_output, 0644, show_fan_step_output,
+static SENSOR_DEVICE_ATTR(pwm2_step_output, 0644, show_fan_step_output,
 	    store_fan_step_output, 1);
-SENSOR_DEVICE_ATTR(pwm3_max_output, 0644, show_fan_max_output,
+static SENSOR_DEVICE_ATTR(pwm3_max_output, 0644, show_fan_max_output,
 	    store_fan_max_output, 2);
-SENSOR_DEVICE_ATTR(pwm3_step_output, 0644, show_fan_step_output,
+static SENSOR_DEVICE_ATTR(pwm3_step_output, 0644, show_fan_step_output,
 	    store_fan_step_output, 2);
 
 static ssize_t
-- 
2.7.4

