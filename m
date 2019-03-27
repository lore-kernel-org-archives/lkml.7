Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D155C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5CA206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MZg2oWcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfC0GV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:21:58 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:26348
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732992AbfC0GV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5YyC5el3pvayqUTWcokVk5ZVoVJyoWi3xhCdsF50jk=;
 b=MZg2oWcOzod4omWqO/lJnPEyAnKLVk/YRA/tclDigqlTquHfnJK+O8K6lb+Yyp2gN5fpBhLSudvy2CTCCpI66zw/yTNaL7FMRojL8IkGT6XuX3eBxFnfMgi7NsjEM6M0YbKYyGLPfyknoJ/Spyf6qog9Ur2lRt0mq61EFWVZ4IM=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1399.eurprd08.prod.outlook.com (10.168.11.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 06:21:55 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 06:21:55 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Joe Perches <joe@perches.com>, Daniel Vetter <daniel@ffwll.ch>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Fix pattern for Documentation path for Arm
 Mali Komeda
Thread-Topic: [PATCH] MAINTAINERS: Fix pattern for Documentation path for Arm
 Mali Komeda
Thread-Index: AQHU5GVfhxPPSVk2CEGmggPenazxlA==
Date:   Wed, 27 Mar 2019 06:21:54 +0000
Message-ID: <20190327062147.GA8455@james-ThinkStation-P300>
References: <20190325233040.30983-1-joe@perches.com>
 <20190326103203.8891-1-Liviu.Dudau@arm.com>
In-Reply-To: <20190326103203.8891-1-Liviu.Dudau@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0212.apcprd02.prod.outlook.com
 (2603:1096:201:20::24) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 557cb6e1-34b0-4df2-640b-08d6b27c81fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1399;
x-ms-traffictypediagnostic: DB6PR0801MB1399:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1399D89D6C103F7B57A740A2B3580@DB6PR0801MB1399.eurprd08.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(86362001)(105586002)(5660300002)(52116002)(33656002)(14454004)(3846002)(6116002)(81156014)(99286004)(1076003)(7736002)(305945005)(68736007)(71190400001)(81166006)(8676002)(106356001)(386003)(71200400001)(55236004)(4744005)(478600001)(76176011)(102836004)(6506007)(8936002)(26005)(14444005)(66066001)(229853002)(6486002)(256004)(6436002)(2906002)(316002)(54906003)(33716001)(58126008)(6862004)(486006)(4326008)(186003)(53936002)(6512007)(476003)(97736004)(6246003)(25786009)(9686003)(11346002)(6636002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1399;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V01KHjKd1WkXiIEajPj1MUtd+HyVwHtS+y3C60Q592UwAqqNa4FWwV0/Y1kMlEbv2n/i2Ldal90WK7z9s72+6mL8T+EuCTzvas6SIrFv4u7seP/NuMSzux/m+pXa3bcfWjlVFv4rOtkq9VorZQgUuSVCdYe0oefd+hKKaadhHmLTVjDokEhSGPr6PO2Mer2Ckaq7HXeM68zl0POZvljxyU+XwozpLoS6gMdOxgPIZldfcDlQ2wZXQlotQvuSoIOQ3JTeUg2LBDvEtVns7Ow6GkfpUe+Zim/CwISZBSDkSzCN8CC1NISpijiTQt3klb7zEEDYP8+asJDAQa/MSUn+AhArVnC4fCi86TCh4lsimjmD/OmKyG0z9FJv8UZv0IECc6CfQ4weC3n3eQxdRD9zDruYHxCFKhpZrtmPnFSbfOc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37D96E6DC2D7934EB2BF81182EF4DB0A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557cb6e1-34b0-4df2-640b-08d6b27c81fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 06:21:54.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:32:03AM +0000, Liviu Dudau wrote:
> The Device Tree bindings documentation file is in a simplified path
> that doesn't match the MAINTAINERS entry.
>=20
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b5480..9fa4686212bdd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1167,7 +1167,7 @@ S:	Supported
>  T:	git git://linux-arm.org/linux-ld.git for-upstream/mali-dp
>  F:	drivers/gpu/drm/arm/display/include/
>  F:	drivers/gpu/drm/arm/display/komeda/
> -F:	Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> +F:	Documentation/devicetree/bindings/display/arm,komeda.txt
>  F:	Documentation/gpu/komeda-kms.rst
> =20
>  ARM MALI-DP DRM DRIVER
> --=20
> 2.21.0

--
Thank you for fixing this problem.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
