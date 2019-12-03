Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456EFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0961420674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="noyK6JNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLCO5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:57:36 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.71]:39987 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfLCO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:57:35 -0500
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-7.bemta.az-b.eu-west-1.aws.symcld.net id FC/82-22075-AD776ED5; Tue, 03 Dec 2019 14:57:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRWlGSWpSXmKPExsWSoc9grXuz/Fm
  swfuf5hZXLh5isljT3MFkMfXhEzaLb1eArMu75rBZdO7qZ7XY8H0towO7x4bPTWweO2fdZfdY
  vOclk8emVZ1sHvveLmPzWL/lKovH501yAexRrJl5SfkVCawZX7c3shfM4K7Yve8tawPjZ44uR
  k4ORoGlzBJTThV0MXIB2cdYJLavvcQI4WxmlPjd+5MNxGEROMEssaKvhRnEERKYwiQxZcIBKO
  cBo8SOlvnMIMPYBCwkJp94ANYiIjCdUeLp5LfsIA6zQAOTxKoVJ5hAqoQF7CQ+PHkM1iEiYC+
  xrPEbO4TtJ7FgxUkwm0VARaJ56TFWEJtXIFHi95Zr7BDrGpglFmz4CtTMwcEpECpxYaMKxBuy
  El8aV4PNZBYQl7j1ZD7YLgkBAYkle84zQ9iiEi8f/2OFqE+VONl0gxEiriNx9voTKFtJYt7cI
  1C2rMSl+d1Qtq9E15FdLDD1k87uhIpbSCzpbmUBOUcC6OZ/hyohwgUSB44fYYOw1SRuvOmAOk
  FG4uClFawgr0gIrGOV+PWwm30Co/4sJGdD2DoSC3Z/YoOwtSWWLXzNPAscFIISJ2c+YVnAyLK
  K0TypKDM9oyQ3MTNH19DAQNfQ0EjX0NJM18hAL7FKN0kvtVS3PLW4RNdQL7G8WK+4Mjc5J0Uv
  L7VkEyMwraUUHBHZwTjh21u9Q4ySHExKorx/Pz+JFeJLyk+pzEgszogvKs1JLT7EKMPBoSTBq
  1j2LFZIsCg1PbUiLTMHmGJh0hIcPEoivG9A0rzFBYm5xZnpEKlTjMYcE17OXcTMsXnu0kXMQi
  x5+XmpUuK8HiClAiClGaV5cINgqf8So6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJaAKkCk8mXk
  lcPteAZ3CBHSKecsjkFNKEhFSUg1MHPViq27+4+g6F9LH8jrk5Y+Gi1PMT85ar1Ua2XhjcU7o
  suV2xecfHBdRuJ/NdC9o6vTTFU/3G6lMv5zu+HD6lh0f5bO3tdZeOvZ/WvDSpQwyx3znZ2XVH
  A7QiGzU7noWPCv126cbDxlmh1VcLahZuSo7pvT6yo0RzD7T1n5ivm+2i82j/Euq2rLm7XktEx
  q/3Yo96J/Bbboj5sWVs0YWK+L0vDy2VOzfvOToxL0lj1NMD5VfvTbLnzPkksb/Yxx9UdKzfB5
  d+rCk8YHYkay89IXrgh2v9c6MmekuuVHFaLryXr3wrTP/fAx03iVqnGGtc+7TypdRBl9Xp1+f
  IxPDLyCYWH1lVhdnNv8HNyYPLyWW4oxEQy3mouJEAMsVoeF4BAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-7.tower-282.messagelabs.com!1575385049!952255!1
X-Originating-IP: [104.47.0.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31054 invoked from network); 3 Dec 2019 14:57:29 -0000
Received: from mail-he1eur01lp2059.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.59)
  by server-7.tower-282.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Dec 2019 14:57:29 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDJGyiF/hG3SrajMuedTp8wcWvdPz4+/2C1jAGdqjOurfMJOZJ3E4HA8x5sWAy2HGTnXZMIgnh7zzaYCzoSOPSATlmoJspw8x63CPb5uCSZLGFfbLpeYlC5DB6hpYGOCGg4Uc5LcNvvSRGjqjuMWn48NYTBs5DxxnOFOXOlJ4rPIfbMYS8HkgTc9lBsQ2igIctOW6Tcrl/BOS3k86B+6AQeDNWWAx6G/EtdTFalIBpAu/3DV8vwRIO4aejmfSLGrPQGOFuSrdq8iOI4xUDlYPNz7QEuJH9Bgz+i/8cW4p3g37P2Ccb8Hy9rF7+WGacLrxN01Iqt5Cc/SuTjEIDkxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peYCYmxNDEvwxL3mKLNja1Bmh6ewFnkiYzb/kxRU4p8=;
 b=aKa3Tlqsd5ln+h/BYbJhlD+dnh7KJK1eFyXlUdbX5zGDsXgyFKsoREB7/p3NO0qGAcqMgYo3jiUSQXTzoJmTtjOBS838MgjDdH2ddC4DUSbuz0J6SakD5vIyynUj1J7SmmpBijSCDtFgZaN3Cz8mUbzGkbaY36eYzmpXnECA2fT4ia+ZftWOD3aNlcdTYs8njwbPDEoqm0l6LCAZlgPxSo1ySOTQW1UJrzRZ63K8jpq0j0JS0kHxtw8JotYmwpKlAVe4f6a+0KEHN+dwOVRXjH/Ny3h+gcYu8wdM7iVx7RtZrNIJZGBIMvnzabtlAb00hRccsI0M+Ndq0bWlgHpuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peYCYmxNDEvwxL3mKLNja1Bmh6ewFnkiYzb/kxRU4p8=;
 b=noyK6JNPJwxbK+Qic0OoAUXvRu4bXh46nRDhlNfP0TpSScONgqpM3t+C485pQ2gbuYZ1rk4/513Lj/B2YcAyKI+vrJiT2oChNgS/6b2B2wolXU1mS37aWqSWW5eH6h9C/Zxe5Mn3JAb5zUWZnamuAKY0hsGZBcyuGm8K7cgYlOk=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1059.EURPRD10.PROD.OUTLOOK.COM (10.169.155.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 14:57:28 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5525:87da:ca4:e8df]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5525:87da:ca4:e8df%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 14:57:28 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Lu, Brent" <brent.lu@intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: remove SRM lock check retry
Thread-Topic: [PATCH] ASoC: da7219: remove SRM lock check retry
Thread-Index: AQHVqaxDP6cBrmECm0aX2T25rtDQx6eoJvjggAAPtwCAAAQYEIAAP/KAgAAFyUA=
Date:   Tue, 3 Dec 2019 14:57:28 +0000
Message-ID: <AM5PR1001MB0994921AE80726BAC59C552B80420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
 <AM5PR1001MB0994EB497D3BC7D0F4C6FD9080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CF33C36214C39B4496568E5578BE70C7403CA7B2@PGSMSX108.gar.corp.intel.com>
 <AM5PR1001MB09946C295B8DAD5F9C8D191080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CF33C36214C39B4496568E5578BE70C7403CACC7@PGSMSX108.gar.corp.intel.com>
In-Reply-To: <CF33C36214C39B4496568E5578BE70C7403CACC7@PGSMSX108.gar.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5a5b641-087c-425c-0121-08d778011d90
x-ms-traffictypediagnostic: AM5PR1001MB1059:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB10597048D192F07E65136892A7420@AM5PR1001MB1059.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(51914003)(199004)(33656002)(110136005)(71190400001)(71200400001)(52536014)(2906002)(305945005)(5660300002)(74316002)(81156014)(2501003)(8676002)(86362001)(7736002)(81166006)(8936002)(14454004)(99286004)(6246003)(54906003)(9686003)(446003)(26005)(102836004)(11346002)(498600001)(55236004)(186003)(55016002)(3846002)(7696005)(66446008)(66946007)(14444005)(229853002)(6506007)(6116002)(66556008)(76116006)(4326008)(64756008)(6436002)(256004)(25786009)(76176011)(53546011)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1059;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sb04F5h+iIQtMsJ7Wkgb0+dzHbZdonypPzM2rdlgxQKzokFblYumwZtBqHFHUadxHRYMtrr48RslroyhABDKuCmenvCbRexlLp6Z4nxiR2yNE7tGeCVSHmlAVcupoEf888lUITZ01JO7ygv5HUTli7hGQ6Qkia8qjFIiL1wVT9q+QTEl/8Mn4KMbV8KVRsIt1mrUi6Fh840V6lMy8zHX9vj1czUgcRnxVuyj/ZpjCgLHKmgeC5ixsA3kz5ZDanjrgcgBETAHWsiXNzvPUPqxqGewm7lolVFf6iegK50NftLAeT3wsmpwag5WhPe6J7H6NyPUVblivR6+qs0gF/mM/qCX6xPJh3lvzUXWhDaGwunTmkWeH4p1g6AL+1JqGrZf3Pn6CkyVc4Fsl8mv1Z7mF9l0/lhJkLSozp3yuBfR1MDPlm62q9Vg1Xt57oxlnceP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a5b641-087c-425c-0121-08d778011d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 14:57:28.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tle34gNxfG2kXneUzZtiECTMr1EwdBAk/gnfwZ4S+A3YcA++ftnGE7U/f9jUwzLu+z/f0nizcb+HnJQw2z7UGGZZXfm9Fur3+Fqm8gjot1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 December 2019 14:36, Brent Lu wrote:

> > But on platforms where they can enable the WCLK early they shouldn't be
> > looping around here for anything like 400ms. In an ideal world when tha=
t
> > widget is run SRM should hopefully be already locked but the code does
> > allow for some delay. Actually, having a long delay also helps show the=
 user
> > that something isn't right here so I'm somewhat loathed to change this.
> >
> > Even if you do reduce the retry timings what you're still not protectin=
g
> > against is the possibility of audio artefacts when SRM finally locks. Y=
ou want
> > this to lock before the any of the audio path is up so I think we need =
to find a
> > way to resolve that rather than relying on getting lucky with a smooth =
power-
> > up.
> >
> Hi Adam,
>=20
> Thanks for the explanation. So the purpose of the code is providing some
> timing tolerance for SRM to lock? If so, I would suggest adding warning m=
essage
> for the lock fail so people have a clue if their design fails the CTS tes=
t. Hard to say
> if Google further reduces the Cold latency again in the future.

Yes, that's right. I have put in a request with our HW team to again clarif=
y
timings, but still awaiting feedback.

The driver already warns via the kernel logs when SRM lock fails as follows=
:

	dev_warn(component->dev, "SRM failed to lock\n");

What else do you think is needed?

>=20
>=20
> Regards,
> Brent
