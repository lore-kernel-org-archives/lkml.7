Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A52CC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC617213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OPGDRxp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDHNon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:44:43 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:46853
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfDHNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCgvNaTfu5xjRJOp8nSra/kB5hoH7Fbmg2T7JC4ktDQ=;
 b=OPGDRxp9YDH+jdcqDzSg/pIoxtGBHuoFBTQ5qbeA4/895S4ZphMe7kEuXUGfKmf1uTi+HJ0NOtaldZJRANct9PB9FPY6pn/xadFhY4B9xf8T33m0t7p4qbhk0/8sug6Gwtj7ebDkhJkiWzrl1aUXwmB3y2/Vs6uDUAEcXCb6ndU=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB4386.eurprd08.prod.outlook.com (20.179.32.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Mon, 8 Apr 2019 13:44:17 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::758d:33f6:320d:a1a3]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::758d:33f6:320d:a1a3%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 13:44:17 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: [PATCH libdrm] headers: Sync with drm-next
Thread-Topic: [PATCH libdrm] headers: Sync with drm-next
Thread-Index: AQHU7hEpHCbXaTxqPk+eq2C0+nBeZw==
Date:   Mon, 8 Apr 2019 13:44:17 +0000
Message-ID: <1554731050-12050-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::14) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 009dafef-fc56-4d72-f447-08d6bc284b96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4386;
x-ms-traffictypediagnostic: AM0PR08MB4386:
x-microsoft-antispam-prvs: <AM0PR08MB4386D0BC8893D3AA27DC93AEE42C0@AM0PR08MB4386.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(366004)(136003)(40434004)(189003)(199004)(14444005)(71200400001)(2201001)(71190400001)(476003)(256004)(5024004)(6486002)(478600001)(97736004)(14454004)(30864003)(53946003)(25786009)(66066001)(86362001)(53936002)(486006)(44832011)(5660300002)(2616005)(6512007)(316002)(7736002)(36756003)(81156014)(2501003)(81166006)(2906002)(72206003)(106356001)(6506007)(6436002)(386003)(110136005)(305945005)(105586002)(8936002)(8676002)(99286004)(26005)(52116002)(50226002)(102836004)(6116002)(3846002)(68736007)(186003)(7416002)(921003)(1121003)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4386;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YAfceruXe9B/o7KEUp59FP0bw66pi+Ouz3+YYMFfDAPSumDSpl92/NY57Wj1NZRvf/th4aFoxffekPWGavpdrhPgp+oNf8atp3c+4sg9K3nYhdmK8P+QVT88dbnEtkoklayD6WMMgnf6FCnFQH2iVQVMC3ge1MiaJ1POrQVX1lDyGiiOoGdHyQy03WjZ+/M0aye1Vd5V8jH2nv9bU11oZRySGnxsF3HV6LxHlO+ZIoYd5JA1VkoQXIfhlaSaMUkXmyXdxjEsiTx+9OoD1fnVxhGfxrnegQzS5GUqh8y9O62oiE0I4gBF2vtWEncNo/vOeDFsod300go9b0BSWn48u9EooJ5y/3Ke/zOLw9e8MtwCT9hweb4n/vayw91Visv3m/zgUptL1XIL+TOoRwRNOntA9UDPiHYpQRsJ7ek0lAs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009dafef-fc56-4d72-f447-08d6bc284b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 13:44:17.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4386
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generated using make headers_install from the drm-next
tree - git://anongit.freedesktop.org/drm/drm
branch - drm-next
commit - 14d2bd53a47a7e1cb3e03d00a6b952734cf90f3f

The changes were as follows :-

core: (drm.h, drm_fourcc.h, drm_mode.h)
- Added 'struct drm_syncobj_transfer', 'struct drm_syncobj_timeline_wait' a=
nd 'struct drm_syncobj_timeline_array'
- Added various DRM_IOCTL_SYNCOBJ_ ioctls
- Added some new RGB and YUV formats
- Added 'DRM_FORMAT_MOD_VENDOR_ALLWINNER'
- Added 'SAMSUNG' and Arm's 'AFBC' and 'ALLWINNER' format modifiers
- Added 'struct drm_mode_rect'

i915:
- Added struct 'struct i915_user_extension' and various 'struct drm_i915_ge=
m_context_'
- Added different modes of per-process Graphics Translation Table

msm:
- Added various get or set GEM buffer info flags
- Added some MSM_SUBMIT_BO_ macros
- Modified 'struct drm_msm_gem_info'

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 include/drm/drm.h        |  36 +++++++
 include/drm/drm_fourcc.h | 136 +++++++++++++++++++++++++++
 include/drm/drm_mode.h   |  23 ++++-
 include/drm/i915_drm.h   | 237 ++++++++++++++++++++++++++++++++++++++++---=
----
 include/drm/msm_drm.h    |  25 +++--
 5 files changed, 415 insertions(+), 42 deletions(-)

diff --git a/include/drm/drm.h b/include/drm/drm.h
index 85c685a..c893f3b 100644
--- a/include/drm/drm.h
+++ b/include/drm/drm.h
@@ -729,8 +729,18 @@ struct drm_syncobj_handle {
 __u32 pad;
 };

+struct drm_syncobj_transfer {
+__u32 src_handle;
+__u32 dst_handle;
+__u64 src_point;
+__u64 dst_point;
+__u32 flags;
+__u32 pad;
+};
+
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time po=
int to become available */
 struct drm_syncobj_wait {
 __u64 handles;
 /* absolute timeout */
@@ -741,12 +751,33 @@ struct drm_syncobj_wait {
 __u32 pad;
 };

+struct drm_syncobj_timeline_wait {
+__u64 handles;
+/* wait on specific timeline point for every handles*/
+__u64 points;
+/* absolute timeout */
+__s64 timeout_nsec;
+__u32 count_handles;
+__u32 flags;
+__u32 first_signaled; /* only valid when not waiting all */
+__u32 pad;
+};
+
+
 struct drm_syncobj_array {
 __u64 handles;
 __u32 count_handles;
 __u32 pad;
 };

+struct drm_syncobj_timeline_array {
+__u64 handles;
+__u64 points;
+__u32 count_handles;
+__u32 pad;
+};
+
+
 /* Query current scanout sequence number */
 struct drm_crtc_get_sequence {
 __u32 crtc_id;/* requested crtc_id */
@@ -903,6 +934,11 @@ extern "C" {
 #define DRM_IOCTL_MODE_GET_LEASEDRM_IOWR(0xC8, struct drm_mode_get_lease)
 #define DRM_IOCTL_MODE_REVOKE_LEASEDRM_IOWR(0xC9, struct drm_mode_revoke_l=
ease)

+#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAITDRM_IOWR(0xCA, struct drm_syncobj_t=
imeline_wait)
+#define DRM_IOCTL_SYNCOBJ_QUERYDRM_IOWR(0xCB, struct drm_syncobj_timeline_=
array)
+#define DRM_IOCTL_SYNCOBJ_TRANSFERDRM_IOWR(0xCC, struct drm_syncobj_transf=
er)
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNALDRM_IOWR(0xCD, struct drm_syncobj=
_timeline_array)
+
 /**
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 139632b..3feeaa3 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -144,6 +144,17 @@ extern "C" {
 #define DRM_FORMAT_RGBA1010102fourcc_code('R', 'A', '3', '0') /* [31:0] R:=
G:B:A 10:10:10:2 little endian */
 #define DRM_FORMAT_BGRA1010102fourcc_code('B', 'A', '3', '0') /* [31:0] B:=
G:R:A 10:10:10:2 little endian */

+/*
+ * Floating point 64bpp RGB
+ * IEEE 754-2008 binary16 half-precision float
+ * [15:0] sign:exponent:mantissa 1:5:10
+ */
+#define DRM_FORMAT_XRGB16161616F fourcc_code('X', 'R', '4', 'H') /* [63:0]=
 x:R:G:B 16:16:16:16 little endian */
+#define DRM_FORMAT_XBGR16161616F fourcc_code('X', 'B', '4', 'H') /* [63:0]=
 x:B:G:R 16:16:16:16 little endian */
+
+#define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0]=
 A:R:G:B 16:16:16:16 little endian */
+#define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0]=
 A:B:G:R 16:16:16:16 little endian */
+
 /* packed YCbCr */
 #define DRM_FORMAT_YUYVfourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb=
0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_YVYUfourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr=
0:Y0 8:8:8:8 little endian */
@@ -151,6 +162,52 @@ extern "C" {
 #define DRM_FORMAT_VYUYfourcc_code('V', 'Y', 'U', 'Y') /* [31:0] Y1:Cb0:Y0=
:Cr0 8:8:8:8 little endian */

 #define DRM_FORMAT_AYUVfourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:Cr=
 8:8:8:8 little endian */
+#define DRM_FORMAT_XYUV8888fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:C=
b:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_VUY888fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y=
 8:8:8 little endian */
+#define DRM_FORMAT_VUY101010fourcc_code('V', 'U', '3', '0') /* Y followed =
by U then V, 10:10:10. Non-linear modifier only */
+
+/*
+ * packed Y2xx indicate for each component, xx valid data occupy msb
+ * 16-xx padding occupy lsb
+ */
+#define DRM_FORMAT_Y210         fourcc_code('Y', '2', '1', '0') /* [63:0] =
Cr0:0:Y1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian per 2 Y pixels */
+#define DRM_FORMAT_Y212         fourcc_code('Y', '2', '1', '2') /* [63:0] =
Cr0:0:Y1:0:Cb0:0:Y0:0 12:4:12:4:12:4:12:4 little endian per 2 Y pixels */
+#define DRM_FORMAT_Y216         fourcc_code('Y', '2', '1', '6') /* [63:0] =
Cr0:Y1:Cb0:Y0 16:16:16:16 little endian per 2 Y pixels */
+
+/*
+ * packed Y4xx indicate for each component, xx valid data occupy msb
+ * 16-xx padding occupy lsb except Y410
+ */
+#define DRM_FORMAT_Y410         fourcc_code('Y', '4', '1', '0') /* [31:0] =
A:Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_Y412         fourcc_code('Y', '4', '1', '2') /* [63:0] =
A:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian */
+#define DRM_FORMAT_Y416         fourcc_code('Y', '4', '1', '6') /* [63:0] =
A:Cr:Y:Cb 16:16:16:16 little endian */
+
+#define DRM_FORMAT_XVYU2101010fourcc_code('X', 'V', '3', '0') /* [31:0] X:=
Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_XVYU12_16161616fourcc_code('X', 'V', '3', '6') /* [63:0=
] X:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian */
+#define DRM_FORMAT_XVYU16161616fourcc_code('X', 'V', '4', '8') /* [63:0] X=
:Cr:Y:Cb 16:16:16:16 little endian */
+
+/*
+ * packed YCbCr420 2x2 tiled formats
+ * first 64 bits will contain Y,Cb,Cr components for a 2x2 tile
+ */
+/* [63:0]   A3:A2:Y3:0:Cr0:0:Y2:0:A1:A0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1=
:1:8:2:8:2:8:2 little endian */
+#define DRM_FORMAT_Y0L0fourcc_code('Y', '0', 'L', '0')
+/* [63:0]   X3:X2:Y3:0:Cr0:0:Y2:0:X1:X0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1=
:1:8:2:8:2:8:2 little endian */
+#define DRM_FORMAT_X0L0fourcc_code('X', '0', 'L', '0')
+
+/* [63:0]   A3:A2:Y3:Cr0:Y2:A1:A0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 lit=
tle endian */
+#define DRM_FORMAT_Y0L2fourcc_code('Y', '0', 'L', '2')
+/* [63:0]   X3:X2:Y3:Cr0:Y2:X1:X0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 lit=
tle endian */
+#define DRM_FORMAT_X0L2fourcc_code('X', '0', 'L', '2')
+
+/*
+ * 1-plane YUV 4:2:0
+ * In these formats, the component ordering is specified (Y, followed by U
+ * then V), but the exact Linear layout is undefined.
+ * These formats can only be used with a non-Linear modifier.
+ */
+#define DRM_FORMAT_YUV420_8BITfourcc_code('Y', 'U', '0', '8')
+#define DRM_FORMAT_YUV420_10BITfourcc_code('Y', 'U', '1', '0')

 /*
  * 2 plane RGB + A
@@ -181,6 +238,34 @@ extern "C" {
 #define DRM_FORMAT_NV42fourcc_code('N', 'V', '4', '2') /* non-subsampled C=
b:Cr plane */

 /*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [10:6] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
+ */
+#define DRM_FORMAT_P210fourcc_code('P', '2', '1', '0') /* 2x1 subsampled C=
r:Cb plane, 10 bit per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [10:6] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
+ */
+#define DRM_FORMAT_P010fourcc_code('P', '0', '1', '0') /* 2x2 subsampled C=
r:Cb plane 10 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [12:4] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
+ */
+#define DRM_FORMAT_P012fourcc_code('P', '0', '1', '2') /* 2x2 subsampled C=
r:Cb plane 12 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:Cb [16:16] little endian
+ */
+#define DRM_FORMAT_P016fourcc_code('P', '0', '1', '6') /* 2x2 subsampled C=
r:Cb plane 16 bits per channel */
+
+/*
  * 3 plane YCbCr
  * index 0: Y plane, [7:0] Y
  * index 1: Cb plane, [7:0] Cb
@@ -223,6 +308,8 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
+#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+
 /* add more to the end as needed */

 #define DRM_FORMAT_RESERVED      ((1ULL << 56) - 1)
@@ -339,6 +426,15 @@ extern "C" {
 #define DRM_FORMAT_MOD_SAMSUNG_64_32_TILEfourcc_mod_code(SAMSUNG, 1)

 /*
+ * Tiled, 16 (pixels) x 16 (lines) - sized macroblocks
+ *
+ * This is a simple tiled layout using tiles of 16x16 pixels in a row-majo=
r
+ * layout. For YCbCr formats Cb/Cr components are taken in such a way that
+ * they correspond to their 16x16 luma block.
+ */
+#define DRM_FORMAT_MOD_SAMSUNG_16_16_TILEfourcc_mod_code(SAMSUNG, 2)
+
+/*
  * Qualcomm Compressed Format
  *
  * Refers to a compressed variant of the base format that is compressed.
@@ -548,6 +644,9 @@ extern "C" {
  * AFBC has several features which may be supported and/or used, which are
  * represented using bits in the modifier. Not all combinations are valid,
  * and different devices or use-cases may support different combinations.
+ *
+ * Further information on the use of AFBC modifiers can be found in
+ * Documentation/gpu/afbc.rst
  */
 #define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)fourcc_mod_code(ARM, __afbc_mo=
de)

@@ -557,10 +656,18 @@ extern "C" {
  * Indicates the superblock size(s) used for the AFBC buffer. The buffer
  * size (in pixels) must be aligned to a multiple of the superblock size.
  * Four lowest significant bits(LSBs) are reserved for block size.
+ *
+ * Where one superblock size is specified, it applies to all planes of the
+ * buffer (e.g. 16x16, 32x8). When multiple superblock sizes are specified=
,
+ * the first applies to the Luma plane and the second applies to the Chrom=
a
+ * plane(s). e.g. (32x8_64x4 means 32x8 Luma, with 64x4 Chroma).
+ * Multiple superblock sizes are only valid for multi-plane YCbCr formats.
  */
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_64x4      (3ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4 (4ULL)

 /*
  * AFBC lossless colorspace transform
@@ -620,6 +727,35 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)

+/*
+ * AFBC double-buffer
+ *
+ * Indicates that the buffer is allocated in a layout safe for front-buffe=
r
+ * rendering.
+ */
+#define AFBC_FORMAT_MOD_DB      (1ULL << 10)
+
+/*
+ * AFBC buffer content hints
+ *
+ * Indicates that the buffer includes per-superblock content hints.
+ */
+#define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
+
+/*
+ * Allwinner tiled modifier
+ *
+ * This tiling mode is implemented by the VPU found on all Allwinner platf=
orms,
+ * codenamed sunxi. It is associated with a YUV format that uses either 2 =
or 3
+ * planes.
+ *
+ * With this tiling, the luminance samples are disposed in tiles represent=
ing
+ * 32x32 pixels and the chrominance samples in tiles representing 32x64 pi=
xels.
+ * The pixel order in each tile is linear and the tiles are disposed linea=
rly,
+ * both in row-major order.
+ */
+#define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/drm/drm_mode.h b/include/drm/drm_mode.h
index d3e0fe3..83cd163 100644
--- a/include/drm/drm_mode.h
+++ b/include/drm/drm_mode.h
@@ -33,7 +33,6 @@
 extern "C" {
 #endif

-#define DRM_DISPLAY_INFO_LEN32
 #define DRM_CONNECTOR_NAME_LEN32
 #define DRM_DISPLAY_MODE_LEN32
 #define DRM_PROP_NAME_LEN32
@@ -622,7 +621,8 @@ struct drm_color_ctm {

 struct drm_color_lut {
 /*
- * Data is U0.16 fixed point format.
+ * Values are mapped linearly to 0.0 - 1.0 range, with 0x0 =3D=3D 0.0 and
+ * 0xffff =3D=3D 1.0.
  */
 __u16 red;
 __u16 green;
@@ -888,6 +888,25 @@ struct drm_mode_revoke_lease {
 __u32 lessee_id;
 };

+/**
+ * struct drm_mode_rect - Two dimensional rectangle.
+ * @x1: Horizontal starting coordinate (inclusive).
+ * @y1: Vertical starting coordinate (inclusive).
+ * @x2: Horizontal ending coordinate (exclusive).
+ * @y2: Vertical ending coordinate (exclusive).
+ *
+ * With drm subsystem using struct drm_rect to manage rectangular area thi=
s
+ * export it to user-space.
+ *
+ * Currently used by drm_mode_atomic blob property FB_DAMAGE_CLIPS.
+ */
+struct drm_mode_rect {
+__s32 x1;
+__s32 y1;
+__s32 x2;
+__s32 y2;
+};
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
index 268b585..2ab257c 100644
--- a/include/drm/i915_drm.h
+++ b/include/drm/i915_drm.h
@@ -63,6 +63,28 @@ extern "C" {
 #define I915_RESET_UEVENT"RESET"

 /*
+ * i915_user_extension: Base class for defining a chain of extensions
+ *
+ * Many interfaces need to grow over time. In most cases we can simply
+ * extend the struct and have userspace pass in more data. Another option,
+ * as demonstrated by Vulkan's approach to providing extensions for forwar=
d
+ * and backward compatibility, is to use a list of optional structs to
+ * provide those extra details.
+ *
+ * The key advantage to using an extension chain is that it allows us to
+ * redefine the interface more easily than an ever growing struct of
+ * increasing complexity, and for large parts of that interface to be
+ * entirely optional. The downside is more pointer chasing; chasing across
+ * the boundary with pointers encapsulated inside u64.
+ */
+struct i915_user_extension {
+__u64 next_extension;
+__u32 name;
+__u32 flags; /* All undefined bits must be zero. */
+__u32 rsvd[4]; /* Reserved for future use; must be zero. */
+};
+
+/*
  * MOCS indexes used for GPU surfaces, defining the cacheability of the
  * surface data and the coherency for this data wrt. CPU vs. GPU accesses.
  */
@@ -99,6 +121,8 @@ enum drm_i915_gem_engine_class {
 I915_ENGINE_CLASS_VIDEO=3D 2,
 I915_ENGINE_CLASS_VIDEO_ENHANCE=3D 3,

+/* should be kept compact */
+
 I915_ENGINE_CLASS_INVALID=3D -1
 };

@@ -319,6 +343,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_I915_PERF_ADD_CONFIG0x37
 #define DRM_I915_PERF_REMOVE_CONFIG0x38
 #define DRM_I915_QUERY0x39
+/* Must be kept compact -- no holes */

 #define DRM_IOCTL_I915_INITDRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_=
i915_init_t)
 #define DRM_IOCTL_I915_FLUSHDRM_IO ( DRM_COMMAND_BASE + DRM_I915_FLUSH)
@@ -367,6 +392,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_GET_SPRITE_COLORKEY DRM_IOWR(DRM_COMMAND_BASE + DRM=
_I915_GET_SPRITE_COLORKEY, struct drm_intel_sprite_colorkey)
 #define DRM_IOCTL_I915_GEM_WAITDRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_WA=
IT, struct drm_i915_gem_wait)
 #define DRM_IOCTL_I915_GEM_CONTEXT_CREATEDRM_IOWR (DRM_COMMAND_BASE + DRM_=
I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create)
+#define DRM_IOCTL_I915_GEM_CONTEXT_CREATE_EXTDRM_IOWR (DRM_COMMAND_BASE + =
DRM_I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create_ext)
 #define DRM_IOCTL_I915_GEM_CONTEXT_DESTROYDRM_IOW (DRM_COMMAND_BASE + DRM_=
I915_GEM_CONTEXT_DESTROY, struct drm_i915_gem_context_destroy)
 #define DRM_IOCTL_I915_REG_READDRM_IOWR (DRM_COMMAND_BASE + DRM_I915_REG_R=
EAD, struct drm_i915_reg_read)
 #define DRM_IOCTL_I915_GET_RESET_STATSDRM_IOWR (DRM_COMMAND_BASE + DRM_I91=
5_GET_RESET_STATS, struct drm_i915_reset_stats)
@@ -412,6 +438,14 @@ typedef struct drm_i915_irq_wait {
 int irq_seq;
 } drm_i915_irq_wait_t;

+/*
+ * Different modes of per-process Graphics Translation Table,
+ * see I915_PARAM_HAS_ALIASING_PPGTT
+ */
+#define I915_GEM_PPGTT_NONE0
+#define I915_GEM_PPGTT_ALIASING1
+#define I915_GEM_PPGTT_FULL2
+
 /* Ioctl to query kernel params:
  */
 #define I915_PARAM_IRQ_ACTIVE            1
@@ -468,6 +502,7 @@ typedef struct drm_i915_irq_wait {
 #define   I915_SCHEDULER_CAP_ENABLED(1ul << 0)
 #define   I915_SCHEDULER_CAP_PRIORITY(1ul << 1)
 #define   I915_SCHEDULER_CAP_PREEMPTION(1ul << 2)
+#define   I915_SCHEDULER_CAP_SEMAPHORES(1ul << 3)

 #define I915_PARAM_HUC_STATUS 42

@@ -551,6 +586,8 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_MMAP_GTT_COHERENT52

+/* Must be kept compact -- no holes and well documented */
+
 typedef struct drm_i915_getparam {
 __s32 param;
 /*
@@ -566,6 +603,7 @@ typedef struct drm_i915_getparam {
 #define I915_SETPARAM_TEX_LRU_LOG_GRANULARITY             2
 #define I915_SETPARAM_ALLOW_BATCHBUFFER                   3
 #define I915_SETPARAM_NUM_USED_FENCES                     4
+/* Must be kept compact -- no holes */

 typedef struct drm_i915_setparam {
 int param;
@@ -964,7 +1002,7 @@ struct drm_i915_gem_execbuffer2 {
  * struct drm_i915_gem_exec_fence *fences.
  */
 __u64 cliprects_ptr;
-#define I915_EXEC_RING_MASK              (7<<0)
+#define I915_EXEC_RING_MASK              (0x3f)
 #define I915_EXEC_DEFAULT                (0<<0)
 #define I915_EXEC_RENDER                 (1<<0)
 #define I915_EXEC_BSD                    (2<<0)
@@ -1112,32 +1150,34 @@ struct drm_i915_gem_busy {
  * as busy may become idle before the ioctl is completed.
  *
  * Furthermore, if the object is busy, which engine is busy is only
- * provided as a guide. There are race conditions which prevent the
- * report of which engines are busy from being always accurate.
- * However, the converse is not true. If the object is idle, the
- * result of the ioctl, that all engines are idle, is accurate.
+ * provided as a guide and only indirectly by reporting its class
+ * (there may be more than one engine in each class). There are race
+ * conditions which prevent the report of which engines are busy from
+ * being always accurate.  However, the converse is not true. If the
+ * object is idle, the result of the ioctl, that all engines are idle,
+ * is accurate.
  *
  * The returned dword is split into two fields to indicate both
- * the engines on which the object is being read, and the
- * engine on which it is currently being written (if any).
+ * the engine classess on which the object is being read, and the
+ * engine class on which it is currently being written (if any).
  *
  * The low word (bits 0:15) indicate if the object is being written
  * to by any engine (there can only be one, as the GEM implicit
  * synchronisation rules force writes to be serialised). Only the
- * engine for the last write is reported.
+ * engine class (offset by 1, I915_ENGINE_CLASS_RENDER is reported as
+ * 1 not 0 etc) for the last write is reported.
  *
- * The high word (bits 16:31) are a bitmask of which engines are
- * currently reading from the object. Multiple engines may be
+ * The high word (bits 16:31) are a bitmask of which engines classes
+ * are currently reading from the object. Multiple engines may be
  * reading from the object simultaneously.
  *
- * The value of each engine is the same as specified in the
- * EXECBUFFER2 ioctl, i.e. I915_EXEC_RENDER, I915_EXEC_BSD etc.
- * Note I915_EXEC_DEFAULT is a symbolic value and is mapped to
- * the I915_EXEC_RENDER engine for execution, and so it is never
+ * The value of each engine class is the same as specified in the
+ * I915_CONTEXT_SET_ENGINES parameter and via perf, i.e.
+ * I915_ENGINE_CLASS_RENDER, I915_ENGINE_CLASS_COPY, etc.
  * reported as active itself. Some hardware may have parallel
  * execution engines, e.g. multiple media engines, which are
- * mapped to the same identifier in the EXECBUFFER2 ioctl and
- * so are not separately reported for busyness.
+ * mapped to the same class identifier and so are not separately
+ * reported for busyness.
  *
  * Caveat emptor:
  * Only the boolean result of this query is reliable; that is whether
@@ -1404,16 +1444,159 @@ struct drm_i915_gem_wait {
 };

 struct drm_i915_gem_context_create {
-/*  output: id of new context*/
-__u32 ctx_id;
+__u32 ctx_id; /* output: id of new context*/
 __u32 pad;
 };

+struct drm_i915_gem_context_create_ext {
+__u32 ctx_id; /* output: id of new context*/
+__u32 flags;
+#define I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS(1u << 0)
+#define I915_CONTEXT_CREATE_FLAGS_UNKNOWN \
+(-(I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS << 1))
+__u64 extensions;
+};
+
+struct drm_i915_gem_context_param {
+__u32 ctx_id;
+__u32 size;
+__u64 param;
+#define I915_CONTEXT_PARAM_BAN_PERIOD0x1
+#define I915_CONTEXT_PARAM_NO_ZEROMAP0x2
+#define I915_CONTEXT_PARAM_GTT_SIZE0x3
+#define I915_CONTEXT_PARAM_NO_ERROR_CAPTURE0x4
+#define I915_CONTEXT_PARAM_BANNABLE0x5
+#define I915_CONTEXT_PARAM_PRIORITY0x6
+#define   I915_CONTEXT_MAX_USER_PRIORITY1023 /* inclusive */
+#define   I915_CONTEXT_DEFAULT_PRIORITY0
+#define   I915_CONTEXT_MIN_USER_PRIORITY-1023 /* inclusive */
+/*
+ * When using the following param, value should be a pointer to
+ * drm_i915_gem_context_param_sseu.
+ */
+#define I915_CONTEXT_PARAM_SSEU0x7
+
+/*
+ * Not all clients may want to attempt automatic recover of a context afte=
r
+ * a hang (for example, some clients may only submit very small incrementa=
l
+ * batches relying on known logical state of previous batches which will n=
ever
+ * recover correctly and each attempt will hang), and so would prefer that
+ * the context is forever banned instead.
+ *
+ * If set to false (0), after a reset, subsequent (and in flight) renderin=
g
+ * from this context is discarded, and the client will need to create a ne=
w
+ * context to use instead.
+ *
+ * If set to true (1), the kernel will automatically attempt to recover th=
e
+ * context by skipping the hanging batch and executing the next batch star=
ting
+ * from the default context state (discarding the incomplete logical conte=
xt
+ * state lost due to the reset).
+ *
+ * On creation, all new contexts are marked as recoverable.
+ */
+#define I915_CONTEXT_PARAM_RECOVERABLE0x8
+/* Must be kept compact -- no holes and well documented */
+
+__u64 value;
+};
+
+/**
+ * Context SSEU programming
+ *
+ * It may be necessary for either functional or performance reason to conf=
igure
+ * a context to run with a reduced number of SSEU (where SSEU stands for S=
lice/
+ * Sub-slice/EU).
+ *
+ * This is done by configuring SSEU configuration using the below
+ * @struct drm_i915_gem_context_param_sseu for every supported engine whic=
h
+ * userspace intends to use.
+ *
+ * Not all GPUs or engines support this functionality in which case an err=
or
+ * code -ENODEV will be returned.
+ *
+ * Also, flexibility of possible SSEU configuration permutations varies be=
tween
+ * GPU generations and software imposed limitations. Requesting such a
+ * combination will return an error code of -EINVAL.
+ *
+ * NOTE: When perf/OA is active the context's SSEU configuration is ignore=
d in
+ * favour of a single global setting.
+ */
+struct drm_i915_gem_context_param_sseu {
+/*
+ * Engine class & instance to be configured or queried.
+ */
+__u16 engine_class;
+__u16 engine_instance;
+
+/*
+ * Unused for now. Must be cleared to zero.
+ */
+__u32 flags;
+
+/*
+ * Mask of slices to enable for the context. Valid values are a subset
+ * of the bitmask value returned for I915_PARAM_SLICE_MASK.
+ */
+__u64 slice_mask;
+
+/*
+ * Mask of subslices to enable for the context. Valid values are a
+ * subset of the bitmask value return by I915_PARAM_SUBSLICE_MASK.
+ */
+__u64 subslice_mask;
+
+/*
+ * Minimum/Maximum number of EUs to enable per subslice for the
+ * context. min_eus_per_subslice must be inferior or equal to
+ * max_eus_per_subslice.
+ */
+__u16 min_eus_per_subslice;
+__u16 max_eus_per_subslice;
+
+/*
+ * Unused for now. Must be cleared to zero.
+ */
+__u32 rsvd;
+};
+
+struct drm_i915_gem_context_create_ext_setparam {
+#define I915_CONTEXT_CREATE_EXT_SETPARAM 0
+struct i915_user_extension base;
+struct drm_i915_gem_context_param param;
+};
+
 struct drm_i915_gem_context_destroy {
 __u32 ctx_id;
 __u32 pad;
 };

+/*
+ * DRM_I915_GEM_VM_CREATE -
+ *
+ * Create a new virtual memory address space (ppGTT) for use within a cont=
ext
+ * on the same file. Extensions can be provided to configure exactly how t=
he
+ * address space is setup upon creation.
+ *
+ * The id of new VM (bound to the fd) for use with I915_CONTEXT_PARAM_VM i=
s
+ * returned in the outparam @id.
+ *
+ * No flags are defined, with all bits reserved and must be zero.
+ *
+ * An extension chain maybe provided, starting with @extensions, and termi=
nated
+ * by the @next_extension being 0. Currently, no extensions are defined.
+ *
+ * DRM_I915_GEM_VM_DESTROY -
+ *
+ * Destroys a previously created VM id, specified in @id.
+ *
+ * No extensions or flags are allowed currently, and so must be zero.
+ */
+struct drm_i915_gem_vm_control {
+__u64 extensions;
+__u32 flags;
+__u32 vm_id;
+};
+
 struct drm_i915_reg_read {
 /*
  * Register offset.
@@ -1426,6 +1609,7 @@ struct drm_i915_reg_read {

 __u64 val; /* Return value */
 };
+
 /* Known registers:
  *
  * Render engine timestamp - 0x2358 + 64bit - gen7+
@@ -1465,22 +1649,6 @@ struct drm_i915_gem_userptr {
 __u32 handle;
 };

-struct drm_i915_gem_context_param {
-__u32 ctx_id;
-__u32 size;
-__u64 param;
-#define I915_CONTEXT_PARAM_BAN_PERIOD0x1
-#define I915_CONTEXT_PARAM_NO_ZEROMAP0x2
-#define I915_CONTEXT_PARAM_GTT_SIZE0x3
-#define I915_CONTEXT_PARAM_NO_ERROR_CAPTURE0x4
-#define I915_CONTEXT_PARAM_BANNABLE0x5
-#define I915_CONTEXT_PARAM_PRIORITY0x6
-#define   I915_CONTEXT_MAX_USER_PRIORITY1023 /* inclusive */
-#define   I915_CONTEXT_DEFAULT_PRIORITY0
-#define   I915_CONTEXT_MIN_USER_PRIORITY-1023 /* inclusive */
-__u64 value;
-};
-
 enum drm_i915_oa_format {
 I915_OA_FORMAT_A13 =3D 1,    /* HSW only */
 I915_OA_FORMAT_A29,    /* HSW only */
@@ -1642,6 +1810,7 @@ struct drm_i915_perf_oa_config {
 struct drm_i915_query_item {
 __u64 query_id;
 #define DRM_I915_QUERY_TOPOLOGY_INFO    1
+/* Must be kept compact -- no holes and well documented */

 /*
  * When set to zero by userspace, this is filled with the size of the
diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
index c06d0a5..91a16b3 100644
--- a/include/drm/msm_drm.h
+++ b/include/drm/msm_drm.h
@@ -105,14 +105,24 @@ struct drm_msm_gem_new {
 __u32 handle;         /* out */
 };

-#define MSM_INFO_IOVA0x01
-
-#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
+/* Get or set GEM buffer info.  The requested value can be passed
+ * directly in 'value', or for data larger than 64b 'value' is a
+ * pointer to userspace buffer, with 'len' specifying the number of
+ * bytes copied into that buffer.  For info returned by pointer,
+ * calling the GEM_INFO ioctl with null 'value' will return the
+ * required buffer size in 'len'
+ */
+#define MSM_INFO_GET_OFFSET0x00   /* get mmap() offset, returned by value =
*/
+#define MSM_INFO_GET_IOVA0x01   /* get iova, returned by value */
+#define MSM_INFO_SET_NAME0x02   /* set the debug name (by pointer) */
+#define MSM_INFO_GET_NAME0x03   /* get debug name, returned by pointer */

 struct drm_msm_gem_info {
 __u32 handle;         /* in */
-__u32 flags;      /* in - combination of MSM_INFO_* flags */
-__u64 offset;         /* out, mmap() offset or iova */
+__u32 info;           /* in - one of MSM_INFO_* */
+__u64 value;          /* in or out */
+__u32 len;            /* in or out */
+__u32 pad;
 };

 #define MSM_PREP_READ        0x01
@@ -188,8 +198,11 @@ struct drm_msm_gem_submit_cmd {
  */
 #define MSM_SUBMIT_BO_READ             0x0001
 #define MSM_SUBMIT_BO_WRITE            0x0002
+#define MSM_SUBMIT_BO_DUMP             0x0004

-#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | MSM_SUBMIT_BO=
_WRITE)
+#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
+MSM_SUBMIT_BO_WRITE | \
+MSM_SUBMIT_BO_DUMP)

 struct drm_msm_gem_submit_bo {
 __u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
