Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2496C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870262133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aWdCjiM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCRTLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:11:55 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:55918
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfCRTLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slh4rtS30Y7N5qQDdu5Z2CRP+0tHbUnYgLVmID7f0Ug=;
 b=aWdCjiM/yFcXzL0S8n1PCDD4MNcU+HnSm8D/5v3rfluP/dvglEEtCd5JkoDAUuwCXOD6iztNvkzBeGB/Z+tXpX6RP6xs/8iBDkFgffFrY37/9oyHXmsRNxhMw0L6TqEDjTiOuIfZiDkOtNrwgK8Ersfctvh8cp3Kc65Nktv5bW0=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3140.eurprd08.prod.outlook.com (52.134.93.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 19:11:49 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 19:11:49 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, nd <nd@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Swati Sharma <swati2.sharma@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Vidya Srinivas <vidya.srinivas@intel.com>
Subject: Re: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Topic: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Index: AQHU2P+qA2ep7AXS+0OoMG0/Q7/SaqYRNbSAgABaAgCAACqQAIAADY8AgAABmACAAAFyAA==
Date:   Mon, 18 Mar 2019 19:11:49 +0000
Message-ID: <20190318191148.mxqo4ljluoqqz6il@DESKTOP-E1NTVVP.localdomain>
References: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
 <dea64e97-1d6b-e728-1e1c-3880e2f0a2e8@linux.intel.com>
 <20190318154004.2llnsarwx77kyqbf@DESKTOP-E1NTVVP.localdomain>
 <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
 <20190318190056.kr7vvgi5qqaiv6qi@DESKTOP-E1NTVVP.localdomain>
 <20190318190638.ryv53gkh3skmajp2@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190318190638.ryv53gkh3skmajp2@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::31) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcc5f60b-1eac-4c41-e3b3-08d6abd59271
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3140;
x-ms-traffictypediagnostic: AM0PR08MB3140:
x-ms-exchange-purlcount: 3
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3140176581D59F8495FA1360F0470@AM0PR08MB3140.eurprd08.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(26005)(6436002)(5660300002)(6486002)(7736002)(66066001)(478600001)(102836004)(53936002)(2906002)(305945005)(316002)(11346002)(6116002)(446003)(486006)(386003)(6246003)(6916009)(6506007)(3846002)(52116002)(476003)(229853002)(72206003)(99286004)(966005)(186003)(25786009)(7416002)(58126008)(14454004)(54906003)(71200400001)(9686003)(105586002)(6306002)(76176011)(6512007)(1076003)(71190400001)(44832011)(106356001)(93886005)(8936002)(4326008)(81166006)(4744005)(86362001)(8676002)(81156014)(68736007)(256004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3140;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cc4YCNQjJlRDZcJH27oIpgVdlf20GJ/W9Tj1DH/YPk9AFY9wOdCP89XUsqx2dOzlkAPWmjHp72NubCaddQBC4HP28ffIfAux+8menQ3YI517NWFHT07t9KPlLGUCc4NYh+Ao7mjOHns1fmF9WtHoJKHjPRBDZ/OkC4Nz4cX5tUH3nPrW5ppA0BRyF8Yd+RegCYCbf0pENqWTpAozn4fNYTvmTGCO84lijrDoBS3V8SaS7Up/6y1xbRkwkL1vq8LOcM41vRfFuH/hz66X751DeUncejE9I6/8FZyHxABgWPhLEOZQ6JGz+Ud3lbRdf39lz2vXMsbx585QUUYjr8hd8fQnNn4ljTKygKdlPf/W/i+WjzrIgjJo92/Vy/ixibeekXxO912vgIwetnsbaFEkgAf1A97RLw95GsHcFO6x7as=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C1CF46D1396BF4A81ED798EF7098118@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc5f60b-1eac-4c41-e3b3-08d6abd59271
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 19:11:49.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:06:39PM +0000, Brian Starkey wrote:
> > [1] https://gitlab.freedesktop.org/gstreamer/gst-plugins-base/commit/0a=
c7d1187b234e86157ad74937c249a3c016807c
>=20
> Eh. I'm not familiar enough with the gitlab UI. Looks like this didn't
> merge in GStreamer so far.

Gah! Still wrong. It's in 1.16, with Alpha:

https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-=
libs/html/gst-plugins-base-libs-GstVideo.html#GstVideoFormat

>=20
> > >=20
> > > > -Brian
> > > >
> > > > [1] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bi=
t-and-16-bit-yuv-video-formats#444-formats
> > >=20
> > >=20
