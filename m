Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92782C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5294D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="xb0w3rY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfCUOPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:15:49 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:24711 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfCUOPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:15:48 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.eu-west-1.aws.symcld.net id A1/47-01080-09C939C5; Thu, 21 Mar 2019 14:15:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwTZxzHee6u16PhlrNA+ImCWZNlQ2mhxMj
  Nv/hLuhEXSIxOZ9QDzraxLV2vxMI/UwTHSyYowgYTigaNMkgJ0YCApgJRICDvvmUolarDZb7A
  lCiRederTP94ks/zfL+/tyfPQ+HqeTKa4l1O3mHjLBpSRZgSVF9rK05V7k50l37ODhZ2K9nJs
  R6MrfL5Sdbdd1PBvp4sxtiJzlMke/b2GMaWdJYr2KIrfUq2dbEFpagMrQsFpKFo/B1paK5vRo
  bLtdNKQ1tTCWm4+s850uC5OEUYFtpi06ldCrMtM8e1T2E6fngI2d+Qrt8utCkOoWFFKVJRBOP
  B4fGxKaW0UTNVGLSWe1EpChU3swhetagkJhkWKvtnSIkjmO+h+P4EKQXgTD8O1XVDhCSEi8LS
  wmmlbNoJvv8KMJk3Q+UNb4AJ5gvobZ4XPRRFMxxMPdfLhYcQ3Fo8H4gNZZLgxN3iACMmBv49/
  AcuMc5EwT2/O5AHGAYau0dwmSNhbnZZIft5GCi4g+TzeBi+7Q+yBurr+oIcA+PusiBvhbe3mg
  PTA/MIQcWr9pVgb027QmYWGsuKCJntcOKlTynzWvDcPYPJwdUkXPj1avDqsuBF3XDQFAtNv/g
  I2TSKw8LoGJLHiYeGrnmyAsXVfjRd7UeSzBvg3Om/cYlpZhUM1PiJBkQ0ITbTYTaanFbObNHq
  ExO1en2SNilRXBuTdVy+NkvH52oP8oJTq9dxBwWdkGfNsmTrbLyzDYnvL9s+uNiBGs8be9BqC
  tNE0vWuyt3qzzJzsvNMnGDa68i18EIPWktRGqCJ30VtlYM38q79Zov4iD/IQIVpIujHtaJMC3
  bOKpiNsjSItJT3jK8OVxO2HBsfHUWnSzkYyWTKta2k+PAVxlFMdDiNQkJC1GF23mE1Oz/Vn6I
  oCmnCaZWUJcxsc65Ueio2gYlNZJ4MNOHk/peiD6FND046t2/pWn6SYE3/oXp13LXOSzv8x9s9
  iy1VFlVqvnXduvzyKOtXS8aykrwfSwuf2K7XFExPfJu25On46+fLl1JmM1L9D3Ylt8TeOzCzj
  a7/KaVi0jvTtOZKRkbDw45neUMPv/mOP5JwdGl5dM/In2n74tJGrNPYl+mTowm9W8vcA3MaQj
  Bx+vW4Q+DeA1yowPkFBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-7.tower-302.messagelabs.com!1553177744!4385855!1
X-Originating-IP: [104.47.10.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22653 invoked from network); 21 Mar 2019 14:15:44 -0000
Received: from mail-db5eur03lp2057.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.57)
  by server-7.tower-302.messagelabs.com with AES256-SHA256 encrypted SMTP; 21 Mar 2019 14:15:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdsZyY7GhIzrotS3rV+OG+KGqizwoeA7aQKnYC4COS8=;
 b=xb0w3rY6A36fUz8JKSpRHVEqVo0X+lA23yNa13Ef93r9w3EViAFu9895uYNPh8VJJF7pWo1Z3EXjApAIYcZKaZL+bu0s9+JkmFtQLBiqeNv1aaBCEe+/W4qmSxyKLVskYEjsWOzxEMLkAua3zzayQL1LmkLth/UbpHBc8oWNhrY=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1026.EURPRD10.PROD.OUTLOOK.COM (10.169.154.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 21 Mar 2019 14:15:41 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d41f:cfb1:4c72:9a4f]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d41f:cfb1:4c72:9a4f%5]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 14:15:41 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 1/3] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK
Thread-Topic: [PATCH 1/3] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK
Thread-Index: AQHU3nwe4JN3I6zws0idIYCxN9PAd6YWBFsAgAAX2WA=
Date:   Thu, 21 Mar 2019 14:15:41 +0000
Message-ID: <AM5PR1001MB0994B0B76F0166D45990E5F980420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
 <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
 <20190321122152.GA5684@sirena.org.uk>
In-Reply-To: <20190321122152.GA5684@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6198e7f6-61bb-4ec6-9f57-08d6ae07b36d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1026;
x-ms-traffictypediagnostic: AM5PR1001MB1026:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1026CE4AC7E0C3254F9FE12AA7420@AM5PR1001MB1026.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39850400004)(136003)(396003)(199004)(189003)(478600001)(99286004)(54906003)(6436002)(72206003)(110136005)(316002)(71200400001)(71190400001)(8676002)(81166006)(9686003)(7416002)(33656002)(81156014)(14454004)(15650500001)(55236004)(55016002)(5660300002)(4744005)(52536014)(6116002)(3846002)(102836004)(229853002)(107886003)(2906002)(76176011)(7696005)(6506007)(53546011)(105586002)(446003)(106356001)(256004)(476003)(11346002)(25786009)(14444005)(4326008)(74316002)(486006)(26005)(186003)(97736004)(68736007)(86362001)(8936002)(305945005)(66066001)(53936002)(6246003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1026;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bkGFpQ4/etcxYjW5cisqPoecEYLYpkaTpzw0OAaPv/cAFAi55fzrO4VrEs/xbnKgEkmsmSzJzCjA/6MHTUordi7PkKYz4M3oj6GxGN0gUMavd7rsg4/v4CA1F/LmiskRf2kTrXBXtCrnhHI141izUtijVTIad2NrXcOZ3EFuSxZBhYSwcqbm/SvEz2QfJBH9B2kXdmj6yTA5arZAyxFNOArjdv5gw6Ic0ivNwL2Us1c3LoFgLLL36dixHapEap0urji07S8Ki84q60Hgxlvhx8h2+OaGDk3pXVYQ5C9AlJr0PHMhHH2KnQv6ADAipKy6ZaFManMFlgCABLZzrXZhTqqbr2tQV/e9P/xlbpmyHOcyNLEcH0F/BAsC2pfapt05Zr84rVzQIyEsJPk12/0t/oGaHnJ9y9kCBscs7BRtqbQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6198e7f6-61bb-4ec6-9f57-08d6ae07b36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 14:15:41.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 March 2019 12:22, Mark Brown wrote:

> On Tue, Mar 19, 2019 at 05:49:30PM +0000, Adam Thomson wrote:
>=20
> > -- #clock-cells :  Should be set to '<0>', only one clock source
> > provided;
> > -- clock-output-names : Name given for DAI clocks output;
> > +- #clock-cells :  Should be set to '<1>', two clock sources provided;
> > +- clock-output-names : Names given for DAI clock outputs (WCLK &
> > +BCLK);
>=20
> This might need some handling later on as it's a binding change, however =
I can't
> see any current users so hopefully nobody will notice.

No I do not believe there are users of this, other than the AMD board which
doesn't use these bindings. Actually given they're the same bindings, albei=
t
with a different number of cells, I've tested the code with just 1 cell and
1 clock in the DTS and this still works as before so the driver should be
backwards compatible.
