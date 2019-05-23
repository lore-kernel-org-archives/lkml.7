Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C68C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C3C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DGK0NvMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfEWJ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:28:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:28:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9SMj04042166
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:28:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9SMj04042166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603703;
        bh=OLxsc1uLQdoatz4Dim3yH2OHC2yNNq79LqIn7azEto8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DGK0NvMya+QSxSZtf0kqaq4XtV6LUrwcL9nJwR1hZcCy8EVOpHYz1rAUzdc6JlTEb
         6CDMGJrPttNkzzXepi3uadcK7l9ZZJd71SH1xCnaRsVYLJpZ8ni6dI0xZxnxICUzfe
         pa9dvRWmABnXz71xaBH3I6q19EGP04AJXDwRgh0x2IUXSzqKVKkLtQ/c4gD/QPjTtn
         8GLBDHADYUbceplHv0s9sI+kXmwdD//7DsuhQFzOCgyr1ylCpD/hooLET04Nyd3Qni
         IR62pKcyVHY1QU5xZzHCQ77tGNh8Mluprk48czGcJsXHV2O3+lV4+sfxjtxNoAVe83
         iRQgGbiadgoLA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9SL2v4042160;
        Thu, 23 May 2019 02:28:21 -0700
Date:   Thu, 23 May 2019 02:28:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhang Rui <tipbot@zytor.com>
Message-ID: <tip-9ea7612c46586d9eacfd517e73ff76ef294feca0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        mingo@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        rui.zhang@intel.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, len.brown@intel.com,
          mingo@kernel.org, peterz@infradead.org,
          rafael.j.wysocki@intel.com, rui.zhang@intel.com, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <6510b784e16374447965925588ec6e46d5d007d8.1557769318.git.len.brown@intel.com>
References: <6510b784e16374447965925588ec6e46d5d007d8.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] powercap/intel_rapl: Update RAPL domain name and
 debug messages
Git-Commit-ID: 9ea7612c46586d9eacfd517e73ff76ef294feca0
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

Commit-ID:  9ea7612c46586d9eacfd517e73ff76ef294feca0
Gitweb:     https://git.kernel.org/tip/9ea7612c46586d9eacfd517e73ff76ef294feca0
Author:     Zhang Rui <rui.zhang@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:53 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:33 +0200

powercap/intel_rapl: Update RAPL domain name and debug messages

The RAPL domain "name" attribute contains "Package-N", which is ambiguous
on multi-die per-package systems.

Update the name to "package-X-die-Y" on those systems.

No change on systems without multi-die/package.

Update driver debug messages.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org
Link: https://lkml.kernel.org/r/6510b784e16374447965925588ec6e46d5d007d8.1557769318.git.len.brown@intel.com

---
 drivers/powercap/intel_rapl.c | 57 ++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 9202dbcef96d..ad78c1d08260 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -178,12 +178,15 @@ struct rapl_domain {
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
 
+/* maximum rapl package domain name: package-%d-die-%d */
+#define PACKAGE_DOMAIN_NAME_LENGTH 30
 
-/* Each physical package contains multiple domains, these are the common
+
+/* Each rapl package contains multiple domains, these are the common
  * data across RAPL domains within a package.
  */
 struct rapl_package {
-	unsigned int id; /* physical package/socket id */
+	unsigned int id; /* logical die id, equals physical 1-die systems */
 	unsigned int nr_domains;
 	unsigned long domain_map; /* bit map of active domains */
 	unsigned int power_unit;
@@ -198,6 +201,7 @@ struct rapl_package {
 	int lead_cpu; /* one active cpu per package for access */
 	/* Track active cpus */
 	struct cpumask cpumask;
+	char name[PACKAGE_DOMAIN_NAME_LENGTH];
 };
 
 struct rapl_defaults {
@@ -926,8 +930,8 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
 	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Core CPU package %d energy=%dpJ, time=%dus, power=%duW\n",
-		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Core CPU %s energy=%dpJ, time=%dus, power=%duW\n",
+		rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
 
 	return 0;
 }
@@ -951,8 +955,8 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Atom package %d energy=%dpJ, time=%dus, power=%duW\n",
-		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Atom %s energy=%dpJ, time=%dus, power=%duW\n",
+		rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
 
 	return 0;
 }
@@ -1181,7 +1185,7 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 	u64 val;
 
 	for (dmn = 0; dmn < rp->nr_domains; dmn++) {
-		pr_debug("update package %d domain %s data\n", rp->id,
+		pr_debug("update %s domain %s data\n", rp->name,
 			 rp->domains[dmn].name);
 		/* exclude non-raw primitives */
 		for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
@@ -1206,7 +1210,6 @@ static void rapl_unregister_powercap(void)
 static int rapl_package_register_powercap(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
-	char dev_name[17]; /* max domain name = 7 + 1 + 8 for int + 1 for null*/
 	struct powercap_zone *power_zone = NULL;
 	int nr_pl, ret;
 
@@ -1217,20 +1220,16 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
 		if (rd->id == RAPL_DOMAIN_PACKAGE) {
 			nr_pl = find_nr_power_limit(rd);
-			pr_debug("register socket %d package domain %s\n",
-				rp->id, rd->name);
-			memset(dev_name, 0, sizeof(dev_name));
-			snprintf(dev_name, sizeof(dev_name), "%s-%d",
-				rd->name, rp->id);
+			pr_debug("register package domain %s\n", rp->name);
 			power_zone = powercap_register_zone(&rd->power_zone,
 							control_type,
-							dev_name, NULL,
+							rp->name, NULL,
 							&zone_ops[rd->id],
 							nr_pl,
 							&constraint_ops);
 			if (IS_ERR(power_zone)) {
-				pr_debug("failed to register package, %d\n",
-					rp->id);
+				pr_debug("failed to register power zone %s\n",
+					rp->name);
 				return PTR_ERR(power_zone);
 			}
 			/* track parent zone in per package/socket data */
@@ -1256,8 +1255,8 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 						&constraint_ops);
 
 		if (IS_ERR(power_zone)) {
-			pr_debug("failed to register power_zone, %d:%s:%s\n",
-				rp->id, rd->name, dev_name);
+			pr_debug("failed to register power_zone, %s:%s\n",
+				rp->name, rd->name);
 			ret = PTR_ERR(power_zone);
 			goto err_cleanup;
 		}
@@ -1270,7 +1269,7 @@ err_cleanup:
 	 * failed after the first domain setup.
 	 */
 	while (--rd >= rp->domains) {
-		pr_debug("unregister package %d domain %s\n", rp->id, rd->name);
+		pr_debug("unregister %s domain %s\n", rp->name, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 
@@ -1380,8 +1379,8 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 	/* check if the domain is locked by BIOS, ignore if MSR doesn't exist */
 	if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
 		if (val64) {
-			pr_info("RAPL package %d domain %s locked by BIOS\n",
-				rd->rp->id, rd->name);
+			pr_info("RAPL %s domain %s locked by BIOS\n",
+				rd->rp->name, rd->name);
 			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
 		}
 	}
@@ -1410,10 +1409,10 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 	}
 	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
 	if (!rp->nr_domains) {
-		pr_debug("no valid rapl domains found in package %d\n", rp->id);
+		pr_debug("no valid rapl domains found in %s\n", rp->name);
 		return -ENODEV;
 	}
-	pr_debug("found %d domains on package %d\n", rp->nr_domains, rp->id);
+	pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
 
 	rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
 			GFP_KERNEL);
@@ -1446,8 +1445,8 @@ static void rapl_remove_package(struct rapl_package *rp)
 			rd_package = rd;
 			continue;
 		}
-		pr_debug("remove package, undo power limit on %d: %s\n",
-			 rp->id, rd->name);
+		pr_debug("remove package, undo power limit on %s: %s\n",
+			 rp->name, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 	/* do parent zone last */
@@ -1461,6 +1460,7 @@ static struct rapl_package *rapl_add_package(int cpu)
 {
 	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	int ret;
 
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
@@ -1471,6 +1471,13 @@ static struct rapl_package *rapl_add_package(int cpu)
 	rp->id = id;
 	rp->lead_cpu = cpu;
 
+	if (topology_max_die_per_package() > 1)
+		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
+			"package-%d-die-%d", c->phys_proc_id, c->cpu_die_id);
+	else
+		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
+			c->phys_proc_id);
+
 	/* check if the package contains valid domains */
 	if (rapl_detect_domains(rp, cpu) ||
 		rapl_defaults->check_unit(rp, cpu)) {
