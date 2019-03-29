Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C119FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845572183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="CI8DD5Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfC2L2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:28:25 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:50362 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728800AbfC2L2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:28:24 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id BE/E2-13147-5510E9C5; Fri, 29 Mar 2019 11:28:21 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSeUgUcRTH/e0cjebGuCq+llZqw6JjNjcppkI
  qItooQSjosmN2ndyB3dFmd8kMyg6Qji0pu9arDTGyPwSzMpMyKelAra3UrJS1tdKyQ7uLaGdn
  u/77/N73+77z3vAoTHOL1FJ8rpOXRM6mJ6Nw67RIllmOyjKSP9+ZyR7xB0i25+MNxD4a+kSw9
  +tLSPZ8/xsVe6B10TzSVFO1hzQ9aW8gTc+91bhpuCYxHV9NCKI5O3cDYf3qHsZyrpC5177h+c
  hH7EVRFE5XY9CYP6iSHxq6UAVPPAFMefQguHv4BrkXRVIkbYSy12+RzHG0C16cOBoyYfQuFbx
  4ej1kiqVnQ3l+h0oxzQFfa2OYZ8PFM/4Q43QSvPNdwGRW02vBX3suFKqhjyF4eHqpzJH0Oijq
  LSFkRrQOPuw4G/JjdAJ0BcpDOUDTUNHQhikcD/3Pfob966Hg6uAIpT4VWjoCSGE9VHZ6CIV14
  CvfF6xTQU6D4rpZ8i5AdyFo/TaEK57JUNyyO9yrBW/bh3CmDd60HAzXx8D3xzsJpdlNwmDdfk
  JZxgLvSlvCDYlQ5fbjiukuBj+7fuDKNlPh5OUhshBN8vyznOcfSeEpUOl9hXlCPywGbp0I4Cc
  RXoVmmSUhy+q0c4KNMSYnM0ZjCmNkjNNTDFwewxl4F2PhRafEBVUDt9lhcGyxW2yZBpF31qDg
  WWVuQlvrkL8gqwmNplT6eHXvl9IMzShzduYWK+ewrpdcNt7RhMZQlB7UZERZhiZG4rP43I2CL
  Xibv2WgovVx6qTgdWrUjhzO7hCyFOk2YqjGU/5STIOL2SKvTVAzcgYtm6wu8U/E7wv3IZ02Vo
  0iIiI00Tm8ZBec/+sDKIFC+lj1gJwSLYjOP18aCA6hCg4xsL1YHsLJ/ZW0+WjcrgXeAr91kn3
  uiuq8xM7KvrRxHebK+lcrzdNSxb4ilgkce2nK0wlpR73p4+e73a6msfsfFG67J9WnxEc2WGIP
  LSzKOF6/SiueKno5tntZGtGjPX9Z13/z3PvbFYtrR7ePWtLNNadmXlqTur1zw6eR0ooZ7Pyoq
  6Qw4fD0ic19a5v1uMPKGSdjkoP7BeychiHcAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-25.tower-229.messagelabs.com!1553858900!3476446!1
X-Originating-IP: [104.47.9.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29751 invoked from network); 29 Mar 2019 11:28:20 -0000
Received: from mail-ve1eur03lp2056.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.56)
  by server-25.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 29 Mar 2019 11:28:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSHj3EBj5iMYNO4nXSSk64O6uNVbaTOdz1vK+rMNwDY=;
 b=CI8DD5IwRgzsOahzjsCptfUhHk1FatLz4I0y2weRChFwr0YZhON6NnRDJH9+/44jwW9uttsMT23YoAuEIzYAzMcFpuPbJisrbRtiJRM5BnUvTkBXb09BHqY8FUnhW6VHensVCX2n7wVCS8QfNPM52vABnSIgl2j+d49XwuRcR20=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1757.EURPRD10.PROD.OUTLOOK.COM (10.165.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Fri, 29 Mar 2019 11:28:19 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 11:28:19 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     'Wolfram Sang' <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
Thread-Topic: [PATCH 0/6] mfd: da9063: remove platform_data
Thread-Index: AQHU3aIiRxuJGE6LNESZwBdNcQFfU6YigYOwgAAGF5A=
Date:   Fri, 29 Mar 2019 11:28:19 +0000
Message-ID: <VI1PR10MB23529DC9BBD619A8BCD7D363FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3f53ecc-2bfc-4194-8368-08d6b439a513
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1757;
x-ms-traffictypediagnostic: VI1PR10MB1757:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <VI1PR10MB1757AE2DAC8413EF2D8420BFF55A0@VI1PR10MB1757.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(105586002)(68736007)(74316002)(106356001)(99286004)(316002)(6436002)(4744005)(256004)(6506007)(6116002)(3846002)(76176011)(71200400001)(110136005)(6246003)(186003)(14444005)(66066001)(54906003)(2501003)(33656002)(6306002)(55016002)(53936002)(9686003)(93156006)(71190400001)(2940100002)(2906002)(25786009)(4326008)(86362001)(446003)(966005)(11346002)(97736004)(7736002)(8676002)(52536014)(102836004)(476003)(81156014)(7696005)(486006)(53546011)(81166006)(26005)(305945005)(8936002)(229853002)(14454004)(478600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1757;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y+u5o7RTMTqMrN6hIbLB5n1u2ook09Rk888ey4riJ+hu7ZsYJ/rvUOe5wslWLXiVp9CCi6nLdt47NlGkUU/1JT+5iXpeQE3ovv2OEm7Gd4ozVCjIKArQMM69DHm9LSkYhmrgRHZpHG0LODJuAWtfLcHom4cu3035cALNppm/OWsAQZshQUa6WzuVDoDxksbpLMcEyhSHppPG5tB+hvbikanGj9jqnsgVmUyHDdnsKfLiby/EJAUKyLG+0E1RKg/PsUMVScJup53/Tfq3eI9GZlgSCVQqYFQQmrjuIt5E+A8urflb00o4N0NvQTF/zvcIBD+JZzfJ6kWoi7xqPcfAT831kRnNq6mBPigJ050cM/4vqidj1d8dnLnKQhE9XySks9URcPhDHeChqOQeb67HiFAjBO8xvxNXF6RhLpGCjSE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f53ecc-2bfc-4194-8368-08d6b439a513
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:28:19.4308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caveat.

On 29 March 2019 11:02 Steve Twiss, wrote:

> Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
>=20
 [...]
>=20
> I've acked-by and tested-by for all the patches now. Apologies because it=
 took
> such a long time to get around to looking at this.
>=20
> (For my benefit) I regression tested against v5.0 and v5.1-rc1, ok.

These were tested with two extra patches that are not in vanilla v5.0 or v5=
.1.-rc1.

One is in discussion and one is applied to linux-next,=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git=
/commit/?id=3D70b464918e5331e488058870fcc6821d54c4e541

E-mail threads are here:

https://lore.kernel.org/lkml/20190318163132.1BB633FBA2@swsrvapps-01.diasemi=
.com/
https://lore.kernel.org/lkml/20190320120604.7D99B3FBE9@swsrvapps-01.diasemi=
.com/

Regards,
Steve

