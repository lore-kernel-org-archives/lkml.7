Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAA5218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="ghoChMMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDXEIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:08:34 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:54760 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfDXEId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:08:33 -0400
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id 69/7E-26000-E31EFBC5; Wed, 24 Apr 2019 04:08:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSWUwTURSGuTPTdlRGr0XDgQDGGqMiU1uUWBN
  DjHHhxY0XoxB0KkNbbQfsFK3GB00EEUVFELUoghE1IC5Vg0EUA24lEUwJuCRaEEwUsY0QiHEh
  djq4vX33/v89/zk3hybVrcpomnc6eLvAWTXK8ZQprl/FJvc0petuDk4wXGt9TBru+csVho6GM
  0pDcUEnYfB/LVIZ8m8MI0PjowJyiSolcL9TmTLkjktp942q1pIbFRbBmO3crDB/CJQSOSNxzp
  L+p6q96HBUIRpPq3EBAeWvDpPy4QmCXv9blXSg8GUSLvRVK2XlKAE3u9vGbD4Erqo2RSEaRyv
  xHPAMdJESTwmy98yAQjKR+DoBz7pdVCGi6QhsgtEXKtljhq7TbxQyJ0JdnjvEFJ4JJ7x1hMQM
  Tof6oRJCDstD8NlTHQoYh9Pg20ggZEI4Fsre+UJM4kg4W+YKFQKM4UJjOynzVPjYO6qQekA4F
  fy3MuTraXC0toiSORa85w4hmVdBXtOL0JCAnyOoaB4eE+Lh4MgpUqoDeBv4b0fJ17Ng/5eKsd
  gY+Hn1B5LfflZAfd/10OxqbIS67xbZEwc1RT2U7Gkn4fbbh+gYmuP6ZwSZE6Dy7qBS5rlwseo
  T6Qr9y2TwnO6jKhFVgwxGu8Vkdtg4i5XV63SsXp/I6ucvYBN1ei23mzVqc0V2Jy862EQtt1PU
  irtsW6yZWoF3uFFwrzJz8j130MglUzOKognNVGagoildPdGYnbnLzInmTfZcKy82oxia1gCzz
  hfUJtt5E+/MsliDy/lbBjpcM4V5KcmMmMPZRItJlloRSz8433OWVFNCtsBHRzLLuoMmLJnMuc
  KfEr9X3ItioyMYFBYWpg7P4e02i+N/vR9F0kgTwUySosItguNPUn+wCSLYRGlCrdSEg/srRe9
  Fi9PDbgx/TzlZXDAz7VnHjE+zF7bgdx2b6N2rbfmMUugtUT32OY8dGMyv8mx1ltnPswvnHfIG
  UlMb1sxOLT2iS/rydc+p2hlzdyS/X7k8YdvH48czWqpbuhZMX+pOWrE9+UdWy4Ss15UZdZ3Ji
  9oCgrssKYapLr4yMLRvw/oj7Rn3KgkNJZo5fTxpF7lfP4QRdt0DAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-7.tower-346.messagelabs.com!1556078907!6248657!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10943 invoked from network); 24 Apr 2019 04:08:29 -0000
Received: from unknown (HELO apsmtp.lenovo.com) (103.30.234.7)
  by server-7.tower-346.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Apr 2019 04:08:29 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 1DF742D1018AA83E4DEF;
        Wed, 24 Apr 2019 12:08:27 +0800 (CST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.56)
 by HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 24 Apr 2019 12:08:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9C5Ww30wRFTa5xbJSHeIZlpzxIfcOMECp36vLh5ITY=;
 b=ghoChMMl+0J/wNPzoCH4AqEbToqkv+y3VCFGP7pKhAXDsK7KrNP3zEurssZhkEI+rQ4gGTAVcGpX8CRnLtC+kcLdJHeXc0vBf+fGGzwZFIFGJebZ56sVAazwzFnzzxytLlPUFpMMjPZkJxuRRTsnLkaNPjrUOVKLwRobHveSXfw=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB4451.apcprd03.prod.outlook.com (10.170.156.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.9; Wed, 24 Apr 2019 04:08:24 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::a4aa:e39c:b7c9:32f0]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::a4aa:e39c:b7c9:32f0%7]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 04:08:24 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        NingTing Cheng <chengnt@lenovo.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH] dm-writecache: avoid unnecessary lookups
 in writecache_find_entry
Thread-Topic: [External]  Re: [PATCH] dm-writecache: avoid unnecessary lookups
 in writecache_find_entry
Thread-Index: AQHU+euajhv9gusIQ0+PsTQwHmzzOaZKjzCA
Date:   Wed, 24 Apr 2019 04:08:24 +0000
Message-ID: <HK2PR03MB4418482EB0C2C73559FACD7F923C0@HK2PR03MB4418.apcprd03.prod.outlook.com>
References: <20190420162102.6460-1-yehs2007@zoho.com>
 <alpine.LRH.2.02.1904231140240.17390@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1904231140240.17390@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65a359c7-3708-4531-a3ae-08d6c86a7f02
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HK2PR03MB4451;
x-ms-traffictypediagnostic: HK2PR03MB4451:
x-microsoft-antispam-prvs: <HK2PR03MB445134613AE578C0A0EDE0D0923C0@HK2PR03MB4451.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(9686003)(81156014)(53936002)(305945005)(97736004)(81166006)(76116006)(55016002)(7736002)(478600001)(14454004)(7696005)(8936002)(8676002)(74316002)(71190400001)(2906002)(66476007)(66556008)(66946007)(66446008)(73956011)(66066001)(68736007)(4326008)(64756008)(71200400001)(6246003)(25786009)(76176011)(5660300002)(102836004)(26005)(476003)(6506007)(54906003)(52536014)(186003)(6916009)(316002)(86362001)(229853002)(6116002)(99286004)(3846002)(256004)(6436002)(486006)(446003)(33656002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB4451;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: La1KPszpxOIIoN1Owhg4uqDA4D3JPPMDPqA8QJHy9S+X3EvR/dlP3aqG3I6dlLm1NT2CpF/X3qMK1hcKP0NO2XTEP0GKeA2pQvvzxO+cOtoIYlvzFklhFnqyPBHtio+jkFIp8K7mldV5USzjx1WKf5hZm3csGto7Es1yTyTwJt6XIqtGu0XQU078cka7qmEx8BiJsCn9beAeywubjax+boEfqIU8tta0CsXZkRtk2xFuquS1scCHieufhsaEoulYth3sm74b5vSIJgwWZwpQPsCv4MjWMxH+u/8mjZaO1zxzRVO/P1n9kRdhVehslLbGThD/JBMk10e/+6WJV/u+v/44UQMxo2hct3QDusHF/d63qCTsh+5i0agXkgTDeA4T6dm9OT0WBe74eaI0Fm4qWqeEssjTAhbWG4+eaeDtLS4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a359c7-3708-4531-a3ae-08d6c86a7f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 04:08:24.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Sent: Tuesday, April 23, 2019 11:44 PM
>=20
> On Sun, 21 Apr 2019, Huaisheng Ye wrote:
>=20
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > Only when entry has been found, that would only be necessary to check t=
he
> > lowest or highest seq-count.
> >
> > Add local variable "found" in writecache_find_entry, if no entry has be=
en
> > found, it is meaningless that having a useless rb_prev or rb_next.
>=20
>=20
> Hi
>=20
> I don't quite see what is this patch trying to fix.
> Don't fix something that isn't broken

Hi Mikulas,

Thanks for your reply.
This patch is not designed for fixing logical error. That is used for optim=
izing the behavior of writecache_find_entry.

Let me give an example to illustrate the point below.
Suppose that is the case, here is a normal READ bio comes to writecache_map=
. And because of bio's direction is READ, writecache_find_entry would be ca=
lled with flags WFE_RETURN_FOLLOWING.

Now there are two scenarios,=20
1. writecache_find_entry successfully get an existing entry by searching rb=
_tree, we could call it HIT. Then the first 'while' will be finished by 'br=
eak'. Next it will move to second 'while' loop, because of the flags hasn't=
 been marked as WFE_LOWEST_SEQ. writecache_find_entry will try to return an=
 entry with HIGHEST_SEQ, if there are other entries which has same original=
_sector in rb_tree.
For this situation, the current code is okay to deal with it.

2. writecache_find_entry couldn't get an existing entry from rb_tree, we co=
uld call it MISS. Because of same flags WFE_RETURN_FOLLOWING, writecache_fi=
nd_entry will get other entry, which's original_sector will slightly larger=
 than input parameter block, with big probability.
For this scenario, function writecache_find_entry doesn't need to enter sec=
ond 'while' loop. But current code would still try to check there were othe=
r entry with same original_sector.
So the additional rb_next or rb_prev is unnecessary by this case, also the =
code doesn't need to compare the original_sector of 'e2' with parameter 'bl=
ock'.

My patch is designed to optimize the second case. so we could skip the seco=
nd 'while' loop when the block is missed from rb_tree.

Cheers,
Huaisheng Ye

>=20
> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> > ---
> >  drivers/md/dm-writecache.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > index ddf1732..047ae09 100644
> > --- a/drivers/md/dm-writecache.c
> > +++ b/drivers/md/dm-writecache.c
> > @@ -537,14 +537,18 @@ static struct wc_entry *writecache_find_entry(str=
uct dm_writecache *wc,
> >  {
> >  	struct wc_entry *e;
> >  	struct rb_node *node =3D wc->tree.rb_node;
> > +	bool found =3D false;
> >
> >  	if (unlikely(!node))
> >  		return NULL;
> >
> >  	while (1) {
> >  		e =3D container_of(node, struct wc_entry, rb_node);
> > -		if (read_original_sector(wc, e) =3D=3D block)
> > +		if (read_original_sector(wc, e) =3D=3D block) {
> > +			found =3D true;
> >  			break;
> > +		}
> > +
> >  		node =3D (read_original_sector(wc, e) >=3D block ?
> >  			e->rb_node.rb_left : e->rb_node.rb_right);
> >  		if (unlikely(!node)) {
> > @@ -564,7 +568,8 @@ static struct wc_entry *writecache_find_entry(struc=
t dm_writecache *wc,
> >  		}
> >  	}
> >
> > -	while (1) {
> > +	/* only need to check lowest or highest seq-count when entry has been=
 found */
> > +	while (found) {
> >  		struct wc_entry *e2;
> >  		if (flags & WFE_LOWEST_SEQ)
> >  			node =3D rb_prev(&e->rb_node);
> > @@ -577,6 +582,9 @@ static struct wc_entry *writecache_find_entry(struc=
t dm_writecache *wc,
> >  			return e;
> >  		e =3D e2;
> >  	}
> > +
> > +	/* no entry has been found, return the following entry */
> > +	return e;
> >  }
> >
> >  static void writecache_insert_entry(struct dm_writecache *wc, struct w=
c_entry *ins)
> > --
> > 1.8.3.1
> >
> >
