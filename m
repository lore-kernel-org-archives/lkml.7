Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31277C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D4F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="g5w1oBW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfD2KMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:12:20 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:4420
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfD2KMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8eiD8OVmk5GjtDTrClqvwgOoa1Nd9go9JV0PggyHL0=;
 b=g5w1oBW7hATQjDf2L3oK3tXXEmxjOC/sUgMGLE5R1gVGzPkzmMY48NhacUTkucq1rx97hgqs5UD65R0vbwjR6Zh+YSZU9Czq8gf39mUD/4xG6Dzkea5dvZfAWIIDzLcgpo7Kmt0IEoKF70kAuADs8yjzmCJ3VDag1ySSKf9QmRc=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4926.eurprd08.prod.outlook.com (10.255.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Mon, 29 Apr 2019 10:12:16 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759%4]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 10:12:16 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Yue Haibing <yuehaibing@huawei.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH -next] drm/komeda: remove set but not used variable
 'kcrtc'
Thread-Topic: [PATCH -next] drm/komeda: remove set but not used variable
 'kcrtc'
Thread-Index: AQHU/nQFKRGNoqlbk0+Sig1ICSf+Kg==
Date:   Mon, 29 Apr 2019 10:12:16 +0000
Message-ID: <20190429101209.GA5684@james-ThinkStation-P300>
References: <20190426164202.34932-1-yuehaibing@huawei.com>
In-Reply-To: <20190426164202.34932-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7570a9e2-f74a-487c-ceeb-08d6cc8b27a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4926;
x-ms-traffictypediagnostic: VE1PR08MB4926:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4926A120D0101D8A52CECDD2B3390@VE1PR08MB4926.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(4326008)(446003)(86362001)(11346002)(476003)(8676002)(486006)(5660300002)(6436002)(66066001)(2906002)(256004)(14444005)(71200400001)(14454004)(25786009)(1076003)(186003)(81156014)(97736004)(81166006)(8936002)(71190400001)(6916009)(102836004)(68736007)(53936002)(76176011)(6512007)(9686003)(7736002)(66446008)(66556008)(26005)(6506007)(55236004)(6246003)(386003)(478600001)(52116002)(33716001)(305945005)(316002)(99286004)(3846002)(6116002)(58126008)(33656002)(54906003)(229853002)(6486002)(73956011)(66946007)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4926;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XJpCsxKd3i4+dBh49gLNpYMJ60XSoIn4liWDfQDb3bpCiepoJ+JZ5i5o/zqymEQRQ40u02Qi8nYHGEMtourSlfWGiwm3Le9n7E1y+GLrZvZt7qZqwLc+4q6Yzp+kr5QCrMT376Dxx5ob8SLJP0SFPKhzRjDO+nawFn9CJEfSH7XszbABSWEI1g1A4Su8w2JY6r4Tums2ujpKnq0AG0U2XNe4lVPmd6Gv68rMFS59VyhkrV5PXb0S/D2xSSYiPCwiBpaTNpuLLzmWQB7amyXySFwju/1Qy2Vom3ecpX9P1F/fnejfuZaBLZhWz+OTidXuYuLZvE+0pcakU9hjXIjayUnxH7BO6bmr6seshQr+j2IMpaStGTuyg/grKbnYtKiQcBOc1Aw+gMTAYddrv30yg1N7BsGAcvP5YyU9Qg06Npo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ABD117786B1FE14BA40DDC67A3B1193A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7570a9e2-f74a-487c-ceeb-08d6cc8b27a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 10:12:16.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:42:02AM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/gpu/drm/arm/display/komeda/komeda_plane.c: In function komeda_pla=
ne_atomic_check:
> drivers/gpu/drm/arm/display/komeda/komeda_plane.c:49:22: warning: variabl=
e kcrtc set but not used [-Wunused-but-set-variable]
>=20
> It is never used since introduction in
> commit 7d31b9e7a550 ("drm/komeda: Add komeda_plane/plane_helper_funcs")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index 07ed0cc..0753892 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -55,7 +55,6 @@ komeda_plane_atomic_check(struct drm_plane *plane,
>  	struct komeda_plane_state *kplane_st =3D to_kplane_st(state);
>  	struct komeda_layer *layer =3D kplane->layer;
>  	struct drm_crtc_state *crtc_st;
> -	struct komeda_crtc *kcrtc;
>  	struct komeda_crtc_state *kcrtc_st;
>  	struct komeda_data_flow_cfg dflow;
>  	int err;
> @@ -73,7 +72,6 @@ komeda_plane_atomic_check(struct drm_plane *plane,
>  	if (!crtc_st->active)
>  		return 0;
> =20
> -	kcrtc =3D to_kcrtc(state->crtc);
>  	kcrtc_st =3D to_kcrtc_st(crtc_st);
> =20
>  	err =3D komeda_plane_init_data_flow(state, &dflow);
> --=20
> 2.7.4
>=20

Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

@liviu:
Could you help to apply this patch to our tree.

James
--=20
