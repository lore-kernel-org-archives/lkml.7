Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845E520675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kgx4ijWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfEWJeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:34:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:34:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9Y8uh4043187
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:34:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9Y8uh4043187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558604049;
        bh=NGD0wsFRGpa9vGTLlYFUP9i3pyR82SCX0dygWxXFlrw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kgx4ijWpvcjuf6jUuwn4L2hD0r+uM8lNmXfZqdBSZv9M/hwKl3r1alE7kzzp2noUq
         MY1Skiw8+JPQ24zqh55VaKU24hT0G4VHgReZBX5L+fcoKPruM/CnqkklcwZghIl4AL
         crzwQLKLYQsB2a0bydAGDYWa5Tvx+Hnb9tekZUh3YVTQ5OJbjN99ITg6WEjt13H0m2
         fAfoMLJbeJZrDurh22utyDxeLnotB9cdVyRl94MKE+7aCVWvQmJDy0rvth+mYO9Rid
         afkMT6zOPjP6/u+Y/KUaDHnZt3ZY5Q0At7XXK6Z/zvlAK8tvTTY05ap0gSTTag96f1
         bKJWnl6RJNwiw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9Y7Dc4043180;
        Thu, 23 May 2019 02:34:07 -0700
Date:   Thu, 23 May 2019 02:34:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-835896a59b9577d0bc2131e027c37bdde5b979af@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        len.brown@intel.com, peterz@infradead.org
Reply-To: rui.zhang@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, len.brown@intel.com
In-Reply-To: <facecfd3525d55c2051f63a7ec709aeb03cc1dc1.1557769318.git.len.brown@intel.com>
References: <facecfd3525d55c2051f63a7ec709aeb03cc1dc1.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] hwmon/coretemp: Cosmetic: Rename internal
 variables to zones from packages
Git-Commit-ID: 835896a59b9577d0bc2131e027c37bdde5b979af
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  835896a59b9577d0bc2131e027c37bdde5b979af
Gitweb:     https://git.kernel.org/tip/835896a59b9577d0bc2131e027c37bdde5b979af
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:59:01 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:36 +0200

hwmon/coretemp: Cosmetic: Rename internal variables to zones from packages

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names to
use the more generic thermal "zone" terminology, instead of "package", as
the zones can refer to either packages or die.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: https://lkml.kernel.org/r/facecfd3525d55c2051f63a7ec709aeb03cc1dc1.1557769318.git.len.brown@intel.com

---
 drivers/hwmon/coretemp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index c64ce32d3214..4ebed90d81aa 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -109,10 +109,10 @@ struct platform_data {
 	struct device_attribute name_attr;
 };
 
-/* Keep track of how many package pointers we allocated in init() */
-static int max_packages __read_mostly;
-/* Array of package pointers. Serialized by cpu hotplug lock */
-static struct platform_device **pkg_devices;
+/* Keep track of how many zone pointers we allocated in init() */
+static int max_zones __read_mostly;
+/* Array of zone pointers. Serialized by cpu hotplug lock */
+static struct platform_device **zone_devices;
 
 static ssize_t show_label(struct device *dev,
 				struct device_attribute *devattr, char *buf)
@@ -435,10 +435,10 @@ static int chk_ucode_version(unsigned int cpu)
 
 static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 {
-	int pkgid = topology_logical_die_id(cpu);
+	int id = topology_logical_die_id(cpu);
 
-	if (pkgid >= 0 && pkgid < max_packages)
-		return pkg_devices[pkgid];
+	if (id >= 0 && id < max_zones)
+		return zone_devices[id];
 	return NULL;
 }
 
@@ -544,7 +544,7 @@ static int coretemp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct platform_data *pdata;
 
-	/* Initialize the per-package data structures */
+	/* Initialize the per-zone data structures */
 	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -579,13 +579,13 @@ static struct platform_driver coretemp_driver = {
 
 static struct platform_device *coretemp_device_add(unsigned int cpu)
 {
-	int err, pkgid = topology_logical_die_id(cpu);
+	int err, zoneid = topology_logical_die_id(cpu);
 	struct platform_device *pdev;
 
-	if (pkgid < 0)
+	if (zoneid < 0)
 		return ERR_PTR(-ENOMEM);
 
-	pdev = platform_device_alloc(DRVNAME, pkgid);
+	pdev = platform_device_alloc(DRVNAME, zoneid);
 	if (!pdev)
 		return ERR_PTR(-ENOMEM);
 
@@ -595,7 +595,7 @@ static struct platform_device *coretemp_device_add(unsigned int cpu)
 		return ERR_PTR(err);
 	}
 
-	pkg_devices[pkgid] = pdev;
+	zone_devices[zoneid] = pdev;
 	return pdev;
 }
 
@@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * the rest.
 	 */
 	if (cpumask_empty(&pd->cpumask)) {
-		pkg_devices[topology_logical_die_id(cpu)] = NULL;
+		zone_devices[topology_logical_die_id(cpu)] = NULL;
 		platform_device_unregister(pdev);
 		return 0;
 	}
@@ -741,10 +741,10 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages() * topology_max_die_per_package();
-	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
+	max_zones = topology_max_packages() * topology_max_die_per_package();
+	zone_devices = kcalloc(max_zones, sizeof(struct platform_device *),
 			      GFP_KERNEL);
-	if (!pkg_devices)
+	if (!zone_devices)
 		return -ENOMEM;
 
 	err = platform_driver_register(&coretemp_driver);
@@ -760,7 +760,7 @@ static int __init coretemp_init(void)
 
 outdrv:
 	platform_driver_unregister(&coretemp_driver);
-	kfree(pkg_devices);
+	kfree(zone_devices);
 	return err;
 }
 module_init(coretemp_init)
@@ -769,7 +769,7 @@ static void __exit coretemp_exit(void)
 {
 	cpuhp_remove_state(coretemp_hp_online);
 	platform_driver_unregister(&coretemp_driver);
-	kfree(pkg_devices);
+	kfree(zone_devices);
 }
 module_exit(coretemp_exit)
 
