Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAA8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33EA20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KMemuHfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDDGbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:31:00 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:63875
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfDDGbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31laf60Thts53OQFWwapLcZ/AKxtlJxdH9PIljNVFIE=;
 b=KMemuHfco9XC8bmDhNzkl6Iib1H9lchwr+iOx5FAtFTDfvmWlO6Gb7SvrIFPJn+AizEODYTr3tNtsuDcPDZfMoyGAKGtggM990IJzNnLWsjpBzgUi/GzKnN1I9yZFkgiKp63XQ8Mr85SpVSDpVCPCL++uHMjrlFnfLur5R70B80=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1991.eurprd08.prod.outlook.com (10.168.83.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 06:30:50 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f%2]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 06:30:50 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH] drm/komeda: Fixed warning: Function parameter or member not
 described
Thread-Topic: [PATCH] drm/komeda: Fixed warning: Function parameter or member
 not described
Thread-Index: AQHU6q/xROdSrVPyb0GiuoS8dH3xXQ==
Date:   Thu, 4 Apr 2019 06:30:49 +0000
Message-ID: <20190404062958.6197-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c226b5dc-ee64-4789-b413-08d6b8c7142c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB6PR0801MB1991;
x-ms-traffictypediagnostic: DB6PR0801MB1991:
x-ms-exchange-purlcount: 3
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1991F005CA188AFD8F7B5787B3500@DB6PR0801MB1991.eurprd08.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(53936002)(68736007)(6636002)(386003)(8676002)(71200400001)(6306002)(110136005)(71190400001)(54906003)(103116003)(6116002)(6486002)(186003)(25786009)(97736004)(30864003)(2906002)(86362001)(8936002)(2501003)(478600001)(50226002)(5660300002)(476003)(14444005)(99286004)(7736002)(66066001)(316002)(3846002)(2616005)(6436002)(256004)(966005)(486006)(305945005)(26005)(105586002)(52116002)(4326008)(36756003)(6512007)(81166006)(102836004)(6506007)(1076003)(106356001)(81156014)(14454004)(55236004)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1991;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UFGjtlHFRkyovz8aXUq+/1U49ToxUN5ec6L+1V/WxKDy3c2+eC5BMwA6kobq5+a4w3XTzkBL0p/0l3IzKXwVMVGbuWtLbYo+6LGUx/Z01niyT4lgjK2fWSg7gBEFv+s+6Zmow+h0djZ9EL6c07qwzMeT85RDPFq0u1Io3FS6DZaXcPFPRw/EFlhL1LLDWksA0mXs43M+dzEeicQXxs7olvr3071/lHNVBUaEIVIh3m5sq6kNP208inbOmWFykxN1DjDRmxDuH7kg+9qHJHKnGRTwVsiDf9NAMlIk95sXPaJoqRLPnXs9sals8utS7tKirRTaIOR5s3mEClEz0OtGPXhA1TQ/AitIc3zrJ/380LTFh+5pKrHnePT9Lt96TH0QGqanFf0271kT+SkqdQivPHOjh5Ck/4RKxFBIg8VlUBo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c226b5dc-ee64-4789-b413-08d6b8c7142c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 06:30:50.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1991
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the warnings: Function parameter or member 'xxx' not described
when make htmldocs

This patch depends on:
- https://patchwork.freedesktop.org/series/54448/
- https://patchwork.freedesktop.org/series/54449/
- https://patchwork.freedesktop.org/series/54450/

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 14 ++++--
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 16 +++++--
 .../arm/display/komeda/komeda_framebuffer.h   |  9 +++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   | 18 ++++++--
 .../drm/arm/display/komeda/komeda_pipeline.h  | 43 ++++++++++++++-----
 .../gpu/drm/arm/display/komeda/komeda_plane.c |  8 ++++
 6 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 053b1e3e74be..d335fec1b727 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -18,9 +18,17 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
-/* crtc_atomic_check is the final check stage, so beside build a display d=
ata
- * pipeline according the crtc_state, but still needs to release/disable t=
he
- * unclaimed pipeline resources.
+/**
+ * komeda_crtc_atomic_check - build display output data flow
+ * @crtc: DRM crtc
+ * @state: the crtc state object
+ *
+ * crtc_atomic_check is the final check stage, so beside build a display d=
ata
+ * pipeline according to the crtc_state, but still needs to release or dis=
able
+ * the unclaimed pipeline resources.
+ *
+ * RETURNS:
+ * Zero for success or -errno
  */
 static int
 komeda_crtc_atomic_check(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 0c3e32b596d9..29e03c4e1ffc 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -120,7 +120,7 @@ struct komeda_dev_funcs {
 		      int master_pipe, u32 active_pipes);
 };
=20
-/**
+/*
  * DISPLAY_MODE describes how many display been enabled, and which will be
  * passed to CHIP by &komeda_dev_funcs->change_opmode(), then CHIP can do =
the
  * pipeline resources assignment according to this usage hint.
@@ -145,24 +145,31 @@ enum {
  * control-abilites of device.
  */
 struct komeda_dev {
+	/** @dev: the base device structure */
 	struct device *dev;
+	/** @reg_base: the base address of komeda io space */
 	u32 __iomem   *reg_base;
=20
+	/** @chip: the basic chip information */
 	struct komeda_chip_info chip;
 	/** @fmt_tbl: initialized by &komeda_dev_funcs->init_format_table */
 	struct komeda_format_caps_table fmt_tbl;
 	/** @pclk: APB clock for register access */
 	struct clk *pclk;
-	/** @mck: HW main engine clk */
+	/** @mclk: HW main engine clk */
 	struct clk *mclk;
=20
 	/** @irq: irq number */
 	int irq;
=20
-	struct mutex lock; /* used to protect dpmode */
-	u32 dpmode; /* current display mode */
+	/** @lock: used to protect dpmode */
+	struct mutex lock;
+	/** @dpmode: current display mode */
+	u32 dpmode;
=20
+	/** @n_pipelines: the number of pipe in @pipelines */
 	int n_pipelines;
+	/** @pipelines: the komeda pipelines */
 	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
=20
 	/** @funcs: chip funcs to access to HW */
@@ -175,6 +182,7 @@ struct komeda_dev {
 	 */
 	void *chip_data;
=20
+	/** @debugfs_root: root directory of komeda debugfs */
 	struct dentry *debugfs_root;
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
index 0de2e4a2afd2..ea2fe190c1e3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
@@ -10,11 +10,16 @@
 #include <drm/drm_framebuffer.h>
 #include "komeda_format_caps.h"
=20
-/** struct komeda_fb - entend drm_framebuffer with komeda attribute */
+/**
+ * struct komeda_fb - Entending drm_framebuffer with komeda attribute
+ */
 struct komeda_fb {
 	/** @base: &drm_framebuffer */
 	struct drm_framebuffer base;
-	/* @format_caps: &komeda_format_caps */
+	/**
+	 * @format_caps:
+	 * extends drm_format_info for komeda specific information
+	 */
 	const struct komeda_format_caps *format_caps;
 	/** @aligned_w: aligned frame buffer width */
 	u32 aligned_w;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index b53db1d5b8e1..1d9bc33ba54f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -16,7 +16,9 @@
 #include <video/videomode.h>
 #include <video/display_timing.h>
=20
-/** struct komeda_plane - komeda instance of drm_plane */
+/**
+ * struct komeda_plane - komeda instance of drm_plane
+ */
 struct komeda_plane {
 	/** @base: &drm_plane */
 	struct drm_plane base;
@@ -72,11 +74,13 @@ struct komeda_crtc {
 	 */
 	struct komeda_pipeline *slave;
=20
-	/* this flip_done is for tracing the disable */
+	/** @disable_done: this flip_done is for tracing the disable */
 	struct completion *disable_done;
 };
=20
-/** struct komeda_crtc_state */
+/**
+ * struct komeda_crtc_state
+ */
 struct komeda_crtc_state {
 	/** @base: &drm_crtc_state */
 	struct drm_crtc_state base;
@@ -84,7 +88,15 @@ struct komeda_crtc_state {
 	/* private properties */
=20
 	/* computed state which are used by validate/check */
+	/**
+	 * @affected_pipes:
+	 * the affected pipelines in once display instance
+	 */
 	u32 affected_pipes;
+	/**
+	 * @active_pipes:
+	 * the active pipelines in once display instance
+	 */
 	u32 active_pipes;
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 233e512319e8..b1f813a349a4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -90,32 +90,35 @@ struct komeda_component {
 	u32 __iomem *reg;
 	/** @id: component id */
 	u32 id;
-	/** @hw_ic: component hw id,
-	 *  which is initialized by chip and used by chip only
+	/**
+	 * @hw_id: component hw id,
+	 * which is initialized by chip and used by chip only
 	 */
 	u32 hw_id;
=20
 	/**
 	 * @max_active_inputs:
-	 * @max_active_outpus:
+	 * @max_active_outputs:
 	 *
-	 * maximum number of inputs/outputs that can be active in the same time
+	 * maximum number of inputs/outputs that can be active at the same time
 	 * Note:
 	 * the number isn't the bit number of @supported_inputs or
 	 * @supported_outputs, but may be less than it, since component may not
 	 * support enabling all @supported_inputs/outputs at the same time.
 	 */
 	u8 max_active_inputs;
+	/** @max_active_outputs: maximum number of outputs */
 	u8 max_active_outputs;
 	/**
 	 * @supported_inputs:
 	 * @supported_outputs:
 	 *
-	 * bitmask of BIT(component->id) for the supported inputs/outputs
+	 * bitmask of BIT(component->id) for the supported inputs/outputs,
 	 * describes the possibilities of how a component is linked into a
 	 * pipeline.
 	 */
 	u32 supported_inputs;
+	/** @supported_outputs: bitmask of supported output componenet ids */
 	u32 supported_outputs;
=20
 	/**
@@ -134,7 +137,8 @@ struct komeda_component {
 struct komeda_component_output {
 	/** @component: indicate which component the data comes from */
 	struct komeda_component *component;
-	/** @output_port:
+	/**
+	 * @output_port:
 	 * the output port of the &komeda_component_output.component
 	 */
 	u8 output_port;
@@ -150,11 +154,12 @@ struct komeda_component_output {
 struct komeda_component_state {
 	/** @obj: tracking component_state by drm_atomic_state */
 	struct drm_private_state obj;
+	/** @component: backpointer to the component */
 	struct komeda_component *component;
 	/**
 	 * @binding_user:
-	 * currently bound user, the user can be crtc/plane/wb_conn, which is
-	 * valid decided by @component and @inputs
+	 * currently bound user, the user can be @crtc, @plane or @wb_conn,
+	 * which is valid decided by @component and @inputs
 	 *
 	 * -  Layer: its user always is plane.
 	 * -  compiz/improc/timing_ctrlr: the user is crtc.
@@ -162,20 +167,24 @@ struct komeda_component_state {
 	 * -  scaler: plane when input is layer, wb_conn if input is compiz.
 	 */
 	union {
+		/** @crtc: backpointer for user crtc */
 		struct drm_crtc *crtc;
+		/** @plane: backpointer for user plane */
 		struct drm_plane *plane;
+		/** @wb_conn: backpointer for user wb_connector  */
 		struct drm_connector *wb_conn;
 		void *binding_user;
 	};
+
 	/**
 	 * @active_inputs:
 	 *
 	 * active_inputs is bitmask of @inputs index
 	 *
-	 * -  active_inputs =3D changed_active_inputs + unchanged_active_inputs
-	 * -  affected_inputs =3D old->active_inputs + new->active_inputs;
+	 * -  active_inputs =3D changed_active_inputs | unchanged_active_inputs
+	 * -  affected_inputs =3D old->active_inputs | new->active_inputs;
 	 * -  disabling_inputs =3D affected_inputs ^ active_inputs;
-	 * -  changed_inputs =3D disabling_inputs + changed_active_inputs;
+	 * -  changed_inputs =3D disabling_inputs | changed_active_inputs;
 	 *
 	 * NOTE:
 	 * changed_inputs doesn't include all active_input but only
@@ -183,7 +192,9 @@ struct komeda_component_state {
 	 * level for dirty update.
 	 */
 	u16 active_inputs;
+	/** @changed_active_inputs: bitmask of the changed @active_inputs */
 	u16 changed_active_inputs;
+	/** @affected_inputs: bitmask for affected @inputs */
 	u16 affected_inputs;
 	/**
 	 * @inputs:
@@ -319,14 +330,23 @@ struct komeda_pipeline {
 	int id;
 	/** @avail_comps: available components mask of pipeline */
 	u32 avail_comps;
+	/** @n_layers: the number of layer on @layers */
 	int n_layers;
+	/** @layers: the pipeline layers */
 	struct komeda_layer *layers[KOMEDA_PIPELINE_MAX_LAYERS];
+	/** @n_scalers: the number of scaler on @scalers */
 	int n_scalers;
+	/** @scalers: the pipeline scalers */
 	struct komeda_scaler *scalers[KOMEDA_PIPELINE_MAX_SCALERS];
+	/** @compiz: compositor */
 	struct komeda_compiz *compiz;
+	/** @wb_layer: writeback layer */
 	struct komeda_layer  *wb_layer;
+	/** @improc: post image processor */
 	struct komeda_improc *improc;
+	/** @ctrlr: timing controller */
 	struct komeda_timing_ctrlr *ctrlr;
+	/** @funcs: chip pipeline functions */
 	struct komeda_pipeline_funcs *funcs; /* private pipeline functions */
=20
 	/** @of_node: pipeline dt node */
@@ -347,6 +367,7 @@ struct komeda_pipeline {
 struct komeda_pipeline_state {
 	/** @obj: tracking pipeline_state by drm_atomic_state */
 	struct drm_private_state obj;
+	/** @pipe: backpointer to the pipeline */
 	struct komeda_pipeline *pipe;
 	/** @crtc: currently bound crtc */
 	struct drm_crtc *crtc;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index af51f0cc9c16..68cd2c9e53e8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -38,6 +38,14 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
 	return 0;
 }
=20
+/**
+ * komeda_plane_atomic_check - build input data flow
+ * @plane: DRM plane
+ * @state: the plane state object
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
 int komeda_plane_atomic_check(struct drm_plane *plane,
 			      struct drm_plane_state *state)
 {
--=20
2.17.1

