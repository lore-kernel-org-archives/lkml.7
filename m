Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C16C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1976B2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JcvCqi4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfD3HgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:36:02 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:55936
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfD3HgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go6iQ+1x4JpEwMcwnKDDHRtlLRzUn0NQUZfcb0X8Pmg=;
 b=JcvCqi4x2XVq4Z6AyZ6kOLpnyB8JtWzEK5xTu27Gw2CoqFpTLVb//HGjzRQTOR4c8zClDYUzDmE4Nxb7fzDV0T/mqdm6dfyv2ShwUkNxZAoBYIbGZFlnfG/ppwJ4nwjjOqLni2SUgp0PVDjrM10vbVUhv9JV7YYxSynky0SFgv8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4973.eurprd08.prod.outlook.com (10.255.158.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 07:35:58 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759%4]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 07:35:57 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [v1, 2/2] dt/bindings: drm/komeda: Adds SMMU support for D71
 devicetree
Thread-Topic: [v1, 2/2] dt/bindings: drm/komeda: Adds SMMU support for D71
 devicetree
Thread-Index: AQHU/ydZVkhRNHPXX0aJoYulI/NjeQ==
Date:   Tue, 30 Apr 2019 07:35:57 +0000
Message-ID: <20190430073549.GB9516@james-ThinkStation-P300>
References: <1556605118-22700-3-git-send-email-lowry.li@arm.com>
In-Reply-To: <1556605118-22700-3-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a5673a1-fcc8-4338-78c1-08d6cd3e7bcc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4973;
x-ms-traffictypediagnostic: VE1PR08MB4973:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB49738867D3A15D569F0D2025B33A0@VE1PR08MB4973.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(53936002)(52116002)(14454004)(76176011)(102836004)(71190400001)(71200400001)(9686003)(6512007)(81156014)(4326008)(186003)(6862004)(256004)(8936002)(7736002)(25786009)(305945005)(26005)(8676002)(6246003)(33656002)(81166006)(66066001)(6636002)(2906002)(33716001)(66446008)(11346002)(1076003)(5660300002)(6436002)(64756008)(3846002)(316002)(66556008)(66476007)(386003)(6116002)(86362001)(486006)(446003)(66946007)(476003)(54906003)(68736007)(6486002)(6506007)(478600001)(99286004)(97736004)(229853002)(55236004)(73956011)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4973;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QWtoqMQWlprJ0TD37xLwWdACSr20XiDm4KvXy5q4sugSI3u67Bm9aB0WVcJRH2KCLGJSw/Uem3RzSyhHyfWgbA3k0mBOUPQLwAI0cMs0vvsFCpdznLqrolE2bnAs2m6RDVIAQle6ROWIgVGcPa27AkS46rowlCYsuUft8peTWB+bHzd/7ecfBxlvsUwI2sZeBN6QlqEJnBp9SlIT4vcshsoQcSc8OoczE+QNNx27ZVJrwl2gZcFlIresPrQdexuXNms93+c/frvgsbQelDi0eTCyFbxmk1/Y53QvjL4/QCxjY9rpmGftyF0XqEDfAPZY5cLbSXo1d2CVBx4zhEDycMAZM+dv6YhYidhDrszK20LmcOB/gdK/+fms1r5BKKhreu+j3/9OUMuuDixSu3Ag4zQcJCQnujk/iRNWl6fY79k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <989FF78681E14844A96650083EC0D567@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5673a1-fcc8-4338-78c1-08d6cd3e7bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 07:35:57.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:19:34AM +0000, Lowry Li (Arm Technology China) w=
rote:
> Updates the device-tree doc about how to enable SMMU by devicetree.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  Documentation/devicetree/bindings/display/arm,komeda.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> --=20
> 1.9.1
>=20
> diff --git a/Documentation/devicetree/bindings/display/arm,komeda.txt b/D=
ocumentation/devicetree/bindings/display/arm,komeda.txt
> index 02b2265..b12c045 100644
> --- a/Documentation/devicetree/bindings/display/arm,komeda.txt
> +++ b/Documentation/devicetree/bindings/display/arm,komeda.txt
> @@ -11,6 +11,10 @@ Required properties:
>        - "pclk": for the APB interface clock
>  - #address-cells: Must be 1
>  - #size-cells: Must be 0
> +- iommus: configure the stream id to IOMMU, Must be configured if want t=
o
> +    enable iommu in display. for how to configure this node please refer=
ence
> +        devicetree/bindings/iommu/arm,smmu-v3.txt,
> +        devicetree/bindings/iommu/iommu.txt
> =20
>  Required properties for sub-node: pipeline@nq
>  Each device contains one or two pipeline sub-nodes (at least one), each
> @@ -44,6 +48,9 @@ Example:
>  		interrupts =3D <0 168 4>;
>  		clocks =3D <&dpu_mclk>, <&dpu_aclk>;
>  		clock-names =3D "mclk", "pclk";
> +		iommus =3D <&smmu 0>, <&smmu 1>, <&smmu 2>, <&smmu 3>,
> +			<&smmu 4>, <&smmu 5>, <&smmu 6>, <&smmu 7>,
> +			<&smmu 8>, <&smmu 9>;
> =20
>  		dp0_pipe0: pipeline@0 {
>  			clocks =3D <&fpgaosc2>, <&dpu_aclk>;

Looks good to me

James
--=20
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
