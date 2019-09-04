Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D67C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC48A21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="f1t0YBdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfIDPSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:18:55 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:51936 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729635AbfIDPSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:18:54 -0400
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id 8B/61-05805-BD5DF6D5; Wed, 04 Sep 2019 15:18:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRWlGSWpSXmKPExsWS8eIhj+7tq/m
  xBmfPclisP3WM2WLvu9msFpd3zWGzmNhxlcni3Y9edou2jV8ZLfYc7WB2YPd4v+8qm8fnTXIe
  5+//Yw9gjmLNzEvKr0hgzbh15DRzQYtgxe65y9kbGGfxdTFycQgJNDBJTJ9/ghnCecUosebpb
  Ha4zO2ZU6EyjUwSJ/v6wDKMAkuZJU6fusfYxcgJ5BxjkXhzRQIisYFRovvXZ7AEi8BuZom379
  Uh2icwSfydNxdq1j1GiQPXVzODVLEJaEqcfHMNzBYRCJXYv/MiO4jNLPCfUWL7PSEQW1ggXGL
  V32msEDUREtdv7GeBsI0krm26ygyxTUXi+p55YHFegRiJK/v/QH3Rxiix88gesASnQLTElUnT
  mSDulpWY9ug+E8QycYm502aBLZAQEJBYsuc8M4QtKvHy8T+gOAdQfZDEuy1xIKaEgLLE2ZPuE
  BWyEpfmdzNC2L4Sb2Z8YgVZKyFwk1Hi/s9NLBD1WhKbj+dCmCoS/w5VQpRnS9z8/4ppAqPhLC
  Q3QNg6Egt2f2KDsLUlli18zTwL7DFBiZMzn7AsYGRZxWiRVJSZnlGSm5iZo2toYKBraGika2h
  somtoYqSXWKWbpFdarFueWlyiC+SWF+sVV+Ym56To5aWWbGIEpquUgra+HYwXZ73RO8QoycGk
  JMqr2JwXK8SXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCV/RKfqyQYFFqempFWmYOMHXCpCU4eJREe
  NWB6VOIt7ggMbc4Mx0idYrRmGPCy7mLmDlOrlqyiFmIJS8/L1VKnFcapFQApDSjNA9uECylX2
  KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzCsOcg9PZl4J3D5gwgX6QoQ3szcX5JSSRISUVAP
  TIYmrdbPX/r54UzFph2QN11W17PWcDe4sCpWyHX8MHpyaL7L+w9o5W7jWb7WZUeVQ+dX5h8zH
  uRbhy/Q4Fim+mJfWmZoW+ZWDP3qz7uvDMTtUNz19HFoheffmbB/D7t2VDBXOhvZZk8+cqdl+f
  u2bg8WCRxvFYpderrQ1a147R9tcInTbble2ItcnhcHZwsnCp1J/dd5yrWN0bE+Pi1QVUy33u/
  j1ScT8ljdPFyuvFTGLWT2hwfduXuSMK/yvO5IaZ622fL7kqivvf2lb18d29tnfrs27PGPJWuN
  wKwnxw5ZlDzbYPfjkv3X96X0LS44J/mPUKbhR8mLBeXdXzoPdzWvDeCffzPj9ffo1kbn3lFiK
  MxINtZiLihMBkHi20mQEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-5.tower-346.messagelabs.com!1567610329!552!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9122 invoked from network); 4 Sep 2019 15:18:50 -0000
Received: from unknown (HELO aesmtp.lenovo.com) (104.232.225.12)
  by server-5.tower-346.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Sep 2019 15:18:50 -0000
Received: from HKGWPEMAIL04.lenovo.com (unknown [10.128.3.72])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 333053C4BE353D129112;
        Wed,  4 Sep 2019 11:18:48 -0400 (EDT)
Received: from HKGWPEMAIL01.lenovo.com (10.128.3.69) by
 HKGWPEMAIL04.lenovo.com (10.128.3.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1591.10; Wed, 4 Sep 2019 23:18:46 +0800
Received: from HKEXEDGE02.lenovo.com (10.128.62.72) by HKGWPEMAIL01.lenovo.com
 (10.128.3.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1591.10 via Frontend
 Transport; Wed, 4 Sep 2019 23:18:29 +0800
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (104.47.109.58)
 by HKEXEDGE01.lenovo.com (10.128.62.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1591.10; Wed, 4 Sep 2019 23:18:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnYrV7BSO9Qi+vwlC0eKNo1CUwndTmr3y73BmDxzT6DUiuc2LU9HsUTLMKswqYhfyp4MaUTVkmE+zc4yOKUcD6imVgtUklOEJDPJKo/uyUY7lHJ1/BHViUQzoXjrNmikg6o5sdgB+Jn5knWex/FKfJFfXdzqcNZMYst3FKJokFwcdCR6/m3RTG4/dbd2yxgp8LZt6qqE6QUb5L76/OmeLN3X2t2LVnATI93UsIqa9fh28OHBr7Mz8aHsdZ7szMVNO/hU8NDnEBgsIHwkZ0Ey2Hivr31IimptPCWSFGZuyUjPZDt1Abz1CE2yrKcx2uEaae4cGoXrkPubAvnx+Lcl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Nzzr7wWlLbkHtj2rX7biwCPrXx8C3WZTFT1rNuh5gw=;
 b=i+CmnhWcaUlUduZyNsXWRGIJHAMA4JPHS9TKTeBLWFAp5K4S3Oo3OmZIQzoEq2XJxVcOIOrov8hHMqXqhAIAHP7sQwPtZEmnQUM7KfVbsW4eMXIfjHrSrICqEbiamqyLH/OoEDgGPkW00NvJ2HswJSvQiQ17xH6m+4i5IlabuxO47kBw2oCt+NeAnG+cLY+EhVTQsbDyUh4gRk4iF5Z5bg5xnbTQGUmxOZS3dmB7dryChig58mwwA/Ez/B9q0OTG/XnJD4+Wn4I61nIMi+BMUid3NxWgiNnhlY/gucJo0m06Z3BBpsg/qgETA5jI6eoqFhrPciflXfdcHFCmg1mfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Nzzr7wWlLbkHtj2rX7biwCPrXx8C3WZTFT1rNuh5gw=;
 b=f1t0YBdUCMnQ1r7Q0NaZpuoUnKG293v2PNm/EFO1hai2KO2S3JQE5Xp9u+Xbbb08a8beSrSyodDz+6hwH8wgM5cp1jZSAAoGqHaRPNvcos3cO0w+TVmwzFFDIpGGTWKMwuGNFrKGTNg3c9Nkb7m2KZcD/AsWhlZasDS+Ua6ZHe8=
Received: from SL2PR03MB4425.apcprd03.prod.outlook.com (20.178.163.203) by
 SL2PR03MB4427.apcprd03.prod.outlook.com (20.178.163.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.5; Wed, 4 Sep 2019 15:18:43 +0000
Received: from SL2PR03MB4425.apcprd03.prod.outlook.com
 ([fe80::8589:2a15:f169:4d86]) by SL2PR03MB4425.apcprd03.prod.outlook.com
 ([fe80::8589:2a15:f169:4d86%7]) with mapi id 15.20.2241.012; Wed, 4 Sep 2019
 15:18:43 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "agk@redhat.com" <agk@redhat.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        Tzu ting Yu1 <tyu1@lenovo.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH] dm writecache: skip writecache_wait for
 pmem mode
Thread-Topic: [External]  Re: [PATCH] dm writecache: skip writecache_wait for
 pmem mode
Thread-Index: AQHVYv2oc/+jfoUYskeMVJQ6yGY6a6cbnUDQ
Date:   Wed, 4 Sep 2019 15:18:42 +0000
Message-ID: <SL2PR03MB44250F8E14C877F400295EA892B80@SL2PR03MB4425.apcprd03.prod.outlook.com>
References: <20190902100450.10600-1-yehs2007@zoho.com>
 <alpine.LRH.2.02.1909040444440.11252@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1909040444440.11252@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.116.211.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dd07813-6b06-419f-0d0f-08d7314b2c4a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SL2PR03MB4427;
x-ms-traffictypediagnostic: SL2PR03MB4427:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SL2PR03MB4427102CCC1A7F4456407BC992B80@SL2PR03MB4427.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(189003)(13464003)(199004)(7736002)(5660300002)(6116002)(25786009)(478600001)(3846002)(33656002)(14454004)(6436002)(81166006)(81156014)(8936002)(8676002)(7696005)(305945005)(86362001)(2906002)(316002)(74316002)(66066001)(99286004)(229853002)(446003)(52536014)(66556008)(66446008)(14444005)(6506007)(71200400001)(64756008)(9686003)(76176011)(53936002)(102836004)(55016002)(66946007)(476003)(11346002)(486006)(66476007)(26005)(76116006)(186003)(2501003)(6246003)(256004)(54906003)(71190400001)(4326008)(110136005)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:SL2PR03MB4427;H:SL2PR03MB4425.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BdLGjApG8tYzoxdFx2vMa7b6sTw5ZF7+q+21f2H9iWui47gsWqXmPe5GeJ0QKfAlKQtkfYw6+kOq1m5idKFYHC5qL1xvOBNHmQFaSzZgEYSZ+dx1b+VMsF6swTEc1ztFCETWKpl8wcQoB1sFJIfD15HgmeMqWkeFHYKYmsS6+HkwUQqFErGvm2c4NA5bXpK9kxbQAElQSkMo2cT23cOfIPv2C8KiMxncGfaiVX3613H8JbEU7uAr1sMCDF43cbWWipK1B/dJdj7bLQXvI59HngqTMlc11HxDfKBr3NMM4kIyGKtvhUu9YY5uLYNa8VJQpT4cIdcnRCtmdXfEH+ZaKMrKFR3gCdkeH2iMJsmkIQxjLifVvDqEM0S9F2ulnjrRsxJSkgm/UTEI48H073sBZFHEAHshk7Tq1MWh/x7gQas=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd07813-6b06-419f-0d0f-08d7314b2c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 15:18:42.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez8odjxltUwioQZQfmDD39QwsEZZEwO6soSo0mOmCjXLNNXbkRsGhYYx09ntvlDmPDznkcWGT9ypJai+u+ZlCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4427
X-OriginatorOrg: lenovo.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mikulas Patocka <mpatocka@redhat.com>
> Sent: Wednesday, September 4, 2019 4:49 PM
> On Mon, 2 Sep 2019, Huaisheng Ye wrote:
>=20
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > The array bio_in_progress[2] only have chance to be increased and
> > decreased with ssd mode. For pmem mode, they are not involved at all.
> > So skip writecache_wait_for_ios in writecache_flush for pmem.
> >
> > Suggested-by: Doris Yu <tyu1@lenovo.com>
> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> > ---
> >  drivers/md/dm-writecache.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > index c481947..d06b8aa 100644
> > --- a/drivers/md/dm-writecache.c
> > +++ b/drivers/md/dm-writecache.c
> > @@ -726,7 +726,8 @@ static void writecache_flush(struct dm_writecache *=
wc)
> >  	}
> >  	writecache_commit_flushed(wc);
> >
> > -	writecache_wait_for_ios(wc, WRITE);
> > +	if (!WC_MODE_PMEM(wc))
> > +		writecache_wait_for_ios(wc, WRITE);
> >
> >  	wc->seq_count++;
> >  	pmem_assign(sb(wc)->seq_count, cpu_to_le64(wc->seq_count));
> > --
> > 1.8.3.1
>=20
> I think this is not needed - wait_event in writecache_wait_for_ios exits
> immediatelly if the condition is true.
>=20
> This code path is not so hot that we would need microoptimizations like t=
his to
> avoid function calls.

Hi Mikulas,

Thanks for your reply, I see what you mean, but I can't agree with you.

For pmem mode, this code path (writecache_flush) is much more hot than SSD =
mode.
Because in the code, the AUTOCOMMIT_BLOCKS_PMEM	has been defined to 64, whi=
ch means if more than 64 blocks have been inserted to cache device, also ca=
lled uncommitted, writecache_flush would be called.
Otherwise, there is a timer callback function will be called every 1000 mil=
liseconds.

#define AUTOCOMMIT_BLOCKS_SSD		65536
#define AUTOCOMMIT_BLOCKS_PMEM		64
#define AUTOCOMMIT_MSEC			1000

So when dm-writecache running in working mode, there are continuous WRITE o=
perations has been mapped to writecache_map, writecache_flush will be used =
much more often than SSD mode.

Cheers,
Huaisheng Ye






