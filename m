Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A7E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLJUdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:33:54 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLJUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:33:54 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTiDV-1iI4HB3JXx-00U2pg; Tue, 10 Dec 2019 21:33:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Leach <mike.leach@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: etm4x: fix unused function warning
Date:   Tue, 10 Dec 2019 21:33:19 +0100
Message-Id: <20191210203339.2830960-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PZv6Q0/vdlVSHBHJn7T1gpGLlPiQ8u4vxmASJnEyI/W8tB+C7Ve
 47L8q68zl+iwEznlpWRUChe6lxKnFsHUwqYKFHYEIbeSXPS+U0RIGw0vMzPYEzLaO7TqSw0
 micRDY7OOQhNERdJ52106PBe9uWQunzsjC2rIFxPS12ZjkU/3nYpBC8aWen4FX9z1M4w13Z
 3YVYvWnRVPTW02f6K7rng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5PIKYtZ1FQM=:89IFv7vKvpz0RD/0CpqeCv
 CcwCoqI74Hf/TI75aRAaX6frcGQMdlMQQFv+H1sU3tbdLh52LAaW9L8WVvdSILT5SY667EkZ/
 rs9T7Q4W3kJ52a520xcjkbj5k5q1heM6KFdnk5cdhGywyNK11fDinVVg4UNN/9zeYC3HY+rMP
 JExZUgsk/GPyjEXOdgTD8RvH2vhEdFqrAdLt7IlJsD0YYeX6ErlWIlPuBl58N9vZM3NJezznO
 1GE5RW7AFRScIp9pDOr9n+PMJfvAMZbQMM5O6HdPxem05lmVgLSUUZrOqza0XXkkxQ3hSYCIK
 Bt7vQWLwGd62u/71ZHM2gGcqCn5rkZb16m0jwPnW4VAzteFoZzaopTL447obA2u9JNmmwvslF
 j0TVFDS6ESa6YbaI2uq/+K6KRteoXwOGwYgudAz1diRzJsD2YZX6jS3qIQW6SdWiXd3JaQnDG
 KliVjSAWHp+N+9DhCAJHDExMgq4EuJKoowG6l4nnmIdi6pMZNUL/juWD0ATdyBeYTHdlJa2TV
 JrA9xj/jh67RhmrkQF7qCl3gFVd+d6UoBBsW0YUkQr6hgF2YTpZkCLY/l79PbnLJ3ONScq+Km
 IjtT6V8NbE9zJUM184uQbDybo29+z3uhgzzwvKQB4siR5Za5e47jg9MEt+IXf12FD1LO8xleO
 iWVanHRw/O8zcZflJbjHMSFGMZ3ApihHX8X+D8IHSlTh23XIO+rKrhYRn0W8BXEPQ5hvCo5F9
 +UOnbMA49lZzR9+fNdooTbOM9gC4Rx/fgcmG6nSj/bCpXKWKiypegOyJ4zFV2aaMDWjUgvORM
 4RQcNeyHcNjN2m8FJxOdu2U6DbSado1gqiJsL2w28u1Rf/W+jUtCcfLoKBqnMJml6vpbCr7RM
 1wa7mhMTFhNyS+VcZWAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the newly added code in the etm4x driver is inside of an #ifdef,
and some other code is outside of it, leading to a harmless warning when
CONFIG_CPU_PM is disabled:

drivers/hwtracing/coresight/coresight-etm4x.c:68:13: error: 'etm4_os_lock' defined but not used [-Werror=unused-function]
 static void etm4_os_lock(struct etmv4_drvdata *drvdata)
             ^~~~~~~~~~~~

To avoid the warning and simplify the the #ifdef checks, use
IS_ENABLED() instead, so the compiler can drop the unused functions
without complaining.

Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index dc3f507e7562..a90d757f7043 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1132,7 +1132,6 @@ static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
 	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
 }
 
-#ifdef CONFIG_CPU_PM
 static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
@@ -1402,17 +1401,17 @@ static struct notifier_block etm4_cpu_pm_nb = {
 
 static int etm4_cpu_pm_register(void)
 {
-	return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
+
+	return 0;
 }
 
 static void etm4_cpu_pm_unregister(void)
 {
-	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
 }
-#else
-static int etm4_cpu_pm_register(void) { return 0; }
-static void etm4_cpu_pm_unregister(void) { }
-#endif
 
 static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 {
-- 
2.20.0

