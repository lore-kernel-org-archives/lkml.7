Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B96C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900AE2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="w5WoOM0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCTQDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:03:47 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:36848 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbfCTQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:03:47 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id 66/A3-16347-F54629C5; Wed, 20 Mar 2019 16:03:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUhTURjHPbv3bjdzdZqGT5KC6z3adFh004o
  oifkhsiKRqOxOb26xzbnN0ggqI21KWMOMRm3S0kqtaL2pZKZoVGJmkZplYVmZlL0oBqHSve72
  9uXwP8/v/7ycwzk0ofguDaO5bDtnNbNGpTSQ1EdJY1Xb05xbo3O7ohhP0yOK6X22nqk4UUMyv
  rcdFFPw8yLBPK09LWXKOtslzOG6JhkzdstHMv3XQ1cFaqvcVUhb4+qRaX0VDqn22rn92quD1R
  Jt0Vi0dsgXkSjbQhnMuozsHZQ+99orwuIIyv724xF5AA1PLkCBNImvENBRVyARNgpcJIFCZz7
  yb14jqKq9yZNJtBRrwP3pCw9oOgTPhRZ3lOAh8AUCGkZapYInGCfChffjpKBD8Aa4P+YR/bHQ
  MrJGCJN4DngPeQhBy/E2uHE8V+bvlYeguTlPJoBJeCPca39BCRrhcBg+WDmRQOBQ6O7zTMwDG
  MO5222EX0+Hj2/HRX8K5Nd/lvnji6C1sw/5tRLKu1yUX4fDE0+hGF8H40XDpDAE4G4EnZdKRL
  AQ8lxesZARmg6dFPVM8Lb9EBt/ocBdaRS0AqfC1zOtoicCKo72ikUfE1D8Mp8QboLAC+BKbZT
  /MJFQXNgrO4bmu/45m+uvy/WPyzVxX9Pgwak+shSRFYjRWQ3peruJNRhVmuholUYTo1qiiolR
  s3tVOjWXpUrlzHYry0M1u8emtuWYUo1pajNn9yH+zaVlUpHV6PT59EY0g5Yop8sjkpxbFVN0G
  Wk5etamT7FmGTlbI5pJ00qQW1J5Ns3KpXPZOw1G/uH+xkAHKUPkL3U8ltssrMlmSPejh2gZff
  ds7xmC/tzwgV9Ln/90EwrSnGHmwkLlg0ICFhL0WeY/5X5/hScoPCxYjgICAhRBFs5qMtj/5wM
  olEbKYPkKoUqQwWz/03WAH0jCD3TZXSQMZGf/orADqPnx8mVxy+OTOaezumS0JS4kYc76hGc5
  VFnTro87vF91HcmV9UOL+9+tXvD0efhofF23obF2arsubm1m2XDXWNI8GvX3bNi2ct+3xN0yi
  Ds20laesbS8c/SWY3bCkHTAsWjTvjV5sVPuEI769j2m+3ePwM4lR2aZLJubH8z3Ohs63ihJm5
  7VLCSsNvYXOnZK7AUEAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-8.tower-246.messagelabs.com!1553097822!3244556!1
X-Originating-IP: [104.47.6.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5173 invoked from network); 20 Mar 2019 16:03:42 -0000
Received: from mail-ve1eur02lp2058.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.58)
  by server-8.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 20 Mar 2019 16:03:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcyhZ56KX46IWPTl0tpg2KC249vg/ywzp8zLIRyPs74=;
 b=w5WoOM0p5rRlvURvA9XPGDqDcywy+8YMAuXrHDnS26AAHuSzz7yxErtb04BUHSlaDAfAMVyUxLxbOXkPLsHJjSGuAOSktTNY03RDRtKr+0rekSIugyG8JvV5v1W7K3hKQuSvevUanuQKkXu7r2I+9lP3OtHOyw0e8RpZFyVUweQ=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1SPR8PMB331.EURPRD10.PROD.OUTLOOK.COM (10.166.146.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Wed, 20 Mar 2019 16:03:40 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 16:03:40 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Topic: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Index: AQHU3xVPNB22JzULbU6dt2e6ipsQ4KYUb2uAgAARkNA=
Date:   Wed, 20 Mar 2019 16:03:40 +0000
Message-ID: <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
In-Reply-To: <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a70091b-5cb1-41d0-472c-08d6ad4d9e90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1SPR8PMB331;
x-ms-traffictypediagnostic: VI1SPR8PMB331:
x-microsoft-antispam-prvs: <VI1SPR8PMB33165D85BDD548B6C8F0BD1F5410@VI1SPR8PMB331.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(39850400004)(346002)(189003)(199004)(6436002)(446003)(9686003)(53936002)(1411001)(256004)(76176011)(53546011)(486006)(55016002)(8676002)(6506007)(107886003)(86362001)(6246003)(68736007)(305945005)(97736004)(25786009)(52536014)(74316002)(186003)(478600001)(476003)(7416002)(229853002)(11346002)(6916009)(4326008)(102836004)(7736002)(26005)(6116002)(71200400001)(3846002)(66066001)(71190400001)(316002)(54906003)(14454004)(33656002)(99286004)(106356001)(81156014)(81166006)(5660300002)(7696005)(2906002)(8936002)(105586002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR8PMB331;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bOmFtBL04mb1nqkKzZ5gBHFsncZPu9lSWK74S/4wPdv13Z9n3RUy4kHKKnIDAkAm58zOghkwx1V5iTaep8P1emx+sjkthFxubustmm+Hof8WenCATS0yeaKmZ6FJZPCC1NdQqv7Qekfmu7HKEHf8wJfp4O/vlA8T53j2huHMdcq6BkQHK0dh/6cKBQ1mLfcHIgpN2kA9Gt1W/BTGdXmytRapSi5xcxDL4E/y1B2redkn14upKT/4GHj8OfNexQ+LXYbrzw6VEtcb7oY5IRS9XtKPbMOuWbATejioDrh6Q5lxM4iWG9o2hG63xxcRkA00CrdOsoG4s6MYoCUmVh2cm/XI2ii7YBoskuGxPE1WZozQ9i/PX23I7WVeYaq96smU+xSfuEC5pVXyp1FTl3S+bhJUfLkhcGKH1MLsPZeLjfM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a70091b-5cb1-41d0-472c-08d6ad4d9e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 16:03:40.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR8PMB331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIDIwIE1hcmNoIDIwMTkgMTI6MTcsIEZhYmlvIEVzdGV2YW0gd3JvdGU6
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBpbXg2cWRsLXNhYnJlc2Q6IGNoYW5n
ZSBwaHktbW9kZSB0byB1c2UgcmdtaWktaWQNCj4gDQo+IEhpIFN0ZXZlLA0KPiANCj4gT24gV2Vk
LCBNYXIgMjAsIDIwMTkgYXQgOTowNiBBTSBTdGV2ZSBUd2lzcw0KPiA8c3R3aXNzLm9wZW5zb3Vy
Y2VAZGlhc2VtaS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIFBIWSB1c2VkIG9uIHRoZSBGcmVl
c2NhbGUgaS5NWDZRL0RMIFNBQlJFIGJvYXJkcyBpcyBxdWFsaWZpZWQgYXMNCj4gPiAncmdtaWkn
IGluc3RlYWQgb2YgJ3JnbWlpLWlkJy4gTWVhbmluZyB0aGUgUlggYW5kIFRYIGRlbGF5cyB0aGF0
IHdlcmUNCj4gDQo+IFRoaXMgcGF0Y2ggZGVjbGFyZXMgaXQgYXMgJ3JnbWlpLWlkJywgd2hpY2gg
Y29udHJhZGljdHMgdGhlIGNvbW1pdCBsb2cuDQoNClRoZSBQSFkgdXNlZCBvbiB0aGUgRnJlZXNj
YWxlIGkuTVg2US9ETCBTQUJSRSBib2FyZHMgaXMgcXVhbGlmaWVkIGFzDQoncmdtaWknIGluc3Rl
YWQgb2YgJ3JnbWlpLWlkJy4NCg0KQ2FuIHRoYXQgYmUgcmVhZCB0d28gd2F5cz8NCkkgbWVhbnQg
dGhlIHBoeS1tb2RlIGlzIGN1cnJlbnRseSBxdWFsaWZpZWQgYXMgJ3JnbWlpJyBpbnN0ZWFkIG9m
IHdoYXQgaXQNCnNob3VsZCBiZTogJ3JnbWlpLWlkJy4NCg0KWy4uLl0NCg0KPiA+IFRoaXMgcGF0
Y2ggZml4ZXMgdGhlIG5ldHdvcmsgcHJvYmxlbXMgc2VlbiBvbiB0aGUgRnJlZXNjYWxlIGkuTVg2
US9ETA0KPiANCj4gUGxlYXNlIHByb3ZpZGUgYSBGaXhlcyB0YWcuIEl0IHdvdWxkIGJlIGdvb2Qg
dG8ga25vdyBpZiB0aGlzIGZpeCBuZWVkcw0KPiB0byBiZSBhcHBsaWVkIHRvIG9sZGVyIGtlcm5l
bHMuDQoNCkkgZGlkbid0IHB1dCBhIEZpeGVzIHRhZyBpbiBiZWNhdXNlIEkgZmluZCB0aGlzIHBh
dGNoIGZpeGVzIHY1LjEtcmMxICh3aGljaCBJIHNlZSBhcyBicm9rZW4pLg0KQnV0IHRoZSBwYXRj
aCBpcyBub3QgbmVlZGVkIGluIHY1LjAgYmVjYXVzZSBJIHNlZSB0aGF0IGFzIHdvcmtpbmcuDQpT
byBkaWRuJ3Qgc2VlIHRoZSBuZWVkIGZvciBhIENjOiBzdGFibGUuDQoNClJlZ2FyZHMsDQpTdGV2
ZQ0K
