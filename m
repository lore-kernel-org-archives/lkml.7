Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597B9C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E695218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="nwMUscdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbfGWHqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:46:38 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:48839 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfGWHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:46:37 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 98/58-13662-A5BB63D5; Tue, 23 Jul 2019 07:46:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRWlGSWpSXmKPExsWSoc9ppBu12yz
  W4M4dZov7X48yWlzeNYfNou+cuwOzx51re9g8ni1cz+LxeZNcAHMUa2ZeUn5FAmvGsu9bGQs+
  s1R8OHiQuYGxh6WLkYuDUWAps8Tlkx1MXYycQM4xFok7Vz0g7PWMEg0ThECKWAROMEvcaN7GD
  OIICUxikljw5C47hHOfUeLU48tsIC1sAoYS8968ZwSxRQSKJaYvmgIWZxaIknhybi7YCmEBR4
  neF41sEDVOEvMu7oayjSS6zz5mBbFZBFQlNt2bwA5i8wrESszpWc4MYgsJuEgcmrMMaA4HB6e
  Aq8SvbyIQl8pKfGlczQyxSlzi1pP5YKskBAQkluw5zwxhi0q8fPyPFaI+XqJ9/1t2iLiOxNnr
  TxghbCWJZTdmsULYshKX5ndDxX0lFqw+CBW/BfTvSzMIW0ti1k6Y+TkS7z5egapRk3i3eTNUr
  4zEvrcXWUFhJSHQzSbxfc9eNohfkiU+zD3LPoFRdxaSuyFsHYkFuz+xQdjaEssWvmaeBQ4KQY
  mTM5+wLGBkWcVomVSUmZ5RkpuYmaNraGCga2horGusa2RkpJdYpZuol1qqm5yaV1KUCJTVSyw
  v1iuuzE3OSdHLSy3ZxAhMQSmFzPd2MF6Y+UbvEKMkB5OSKK/9dLNYIb6k/JTKjMTijPii0pzU
  4kOMMhwcShK823cB5QSLUtNTK9Iyc4DpECYtwcGjJMIbCpLmLS5IzC3OTIdInWLU5Zjwcu4iZ
  iGWvPy8VClx3jc7gYoEQIoySvPgRsBS8yVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwry3QF
  bxZOaVwG16BXQEE9ARe1XAjihJREhJNTCVHFV8yb1i71FvJec/iy7+tt+aKxbTfV1SIG3DmqB
  1M+odDVdf0D+y66hm9MxpXP43u1cGXjQv2tme+vX+LJkXDq52CkWv4ta9vMTOMHHChUQ2/sQ1
  uXXXXE2qWRyeHJl9nXntg6aWBWcDp4ZfOJgtksU0aZ3h1Fl17wQsnkx7k3F8/8VvpgkTz9axs
  i7MNPSb4LRM63UW/xEzjuqFc150Lrtm9tv/eFx6Q+TuXovtCtlmUw9Ojli981k4n5nigbO52+
  x+eCzNnsVnH9pjrpd3/Yj+r6s8EzdvN5NpdefhZtgQFT3td9yJVpm07GjTEttt8ut0pj874z3
  598TJqTZHmzcfn/xTYt/mFKOzbN1ZSizFGYmGWsxFxYkASd1buUgEAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-23.tower-223.messagelabs.com!1563867993!75705!1
X-Originating-IP: [104.47.9.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4614 invoked from network); 23 Jul 2019 07:46:34 -0000
Received: from mail-ve1eur03lp2050.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.50)
  by server-23.tower-223.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 23 Jul 2019 07:46:34 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G58VyDlvMgMLatKc4rr2ObO2t7vUkz7vXY+YTGi1dQzhJ40lSf+W0HlB+ZE5mTXo9+gWN34868zJCQOywsUriJyiV80I0jpS9ZJdfHktG2yIr4nZsoC2C4uGh44G5dqLxk6iSV/QnAOhH/bi7jbE+b2mL8EWs69U4xDNJm34M83qPsnMf4U0RY1wR8Gk2L/+i43xHpT7hRDlj1vGRXRNZuWyoNBTPd+I5YVTrNRqwZBedgwJuu2N6s6ZjBzSqkqYh6PtHHNiH3iGyJO8nhdeUxDNzOHPTszkB/neuSCCBftC/nkfTxPimtyWFGOnRpRjZkZfyRrLmLDcGlnPDBZ8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxUJIe14Wq786IbDjx0g6MgxZjm8hxrA1uWm7jtaZI8=;
 b=LzrI6r2wPYrcA/idpOyPOEMYivqZNkSOYHRoPRdb9nwoGMKztRBcSjWMEV9WmsUQVtUgQMBwOU0zpQEhL2AxP85lkumrPmsoCNI7fBO4W6olla0nB3Sbu0P6CwyYeECn0baEEmazG28EBHCIqgyi5SRN0iThoZ0U4Pj2EVOqi2ZDoW1F9gma7oFq9wuR/FqcK1bjuWmIoCUof0Yr0ZNH955wIna6kxNjLXsS9ygR+V4tR2P5qQamY+uvflOaxAGBZgT90VXlzr6SC5AUsWVKyqHTGtxL5bpjMsq7R5Vap8uWPAKsITClRPaOmmqRNcg0NHgK/v9ydlL4/2jzB7ivQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=diasemi.com;dmarc=pass action=none
 header.from=diasemi.com;dkim=pass header.d=diasemi.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxUJIe14Wq786IbDjx0g6MgxZjm8hxrA1uWm7jtaZI8=;
 b=nwMUscddHyJ4oripDMqK5QV+Ab+ZvEpO1l4tMKRPzUHIOemwKQasKeLqgARgEH2Marg1wZ8gHdzO9i+8cRLDjyVy0HhSjy/bgHDrY30p9SAlGKGu7rLYR7d3x7K+J3dYwkUCblvLUggC+Tj60PWycmYJjc8xhKIy6nrvEe9qSUE=
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM (20.177.113.222) by
 AM6PR10MB1943.EURPRD10.PROD.OUTLOOK.COM (52.134.117.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Tue, 23 Jul 2019 07:46:32 +0000
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e011:a77f:4065:5798]) by AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e011:a77f:4065:5798%3]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 07:46:32 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: RE: [PATCH] mfd: da9063: remove now unused platform_data
Thread-Topic: [PATCH] mfd: da9063: remove now unused platform_data
Thread-Index: AQHVQLsM5bJ5W86gXUiinLCTek12g6bX01Lw
Date:   Tue, 23 Jul 2019 07:46:32 +0000
Message-ID: <AM6PR10MB2181D3B706CBEB23C55938F8FEC70@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
References: <20190722182628.7533-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190722182628.7533-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4b2785e-0052-4c2e-e511-08d70f41e194
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB1943;
x-ms-traffictypediagnostic: AM6PR10MB1943:
x-microsoft-antispam-prvs: <AM6PR10MB1943CA145FFF7D8F1687B09AF5C70@AM6PR10MB1943.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(102836004)(110136005)(7736002)(66066001)(54906003)(305945005)(6506007)(53546011)(99286004)(446003)(26005)(4744005)(25786009)(7696005)(74316002)(53936002)(11346002)(55016002)(9686003)(2906002)(6246003)(186003)(486006)(476003)(66446008)(68736007)(4326008)(8936002)(33656002)(76116006)(81156014)(81166006)(66476007)(66556008)(66946007)(64756008)(8676002)(3846002)(6116002)(52536014)(76176011)(14444005)(256004)(71190400001)(71200400001)(2501003)(86362001)(478600001)(6436002)(5660300002)(229853002)(14454004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB1943;H:AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J2ia2MmDcGJNtJ7swWaWc2cuoDjxGhPeRJJ+/l7rIUyqeRA2puWt4p6WCxNzdrTFhCLC6gxki/YWbmXYFV+vQIZglVIfwN+Oc8l/7ZPuR4Td5NH0O+I+DmpBGHR6ZjNXGziQhsjKf7x7ERsa9NqWS+IvfVlx+yCdu9+U3zOI4DlH6W9Golu0QmiT9VRxRjIZCioShHR02CCn5DLhEZG91eFS/W7Jc2dt8q8TzgxKLdLuJET8L0CbheTB3K7GwCUyZEDwvdafIcMvdl9J71Fok1eaRDhPYEpb2g656fJ8fuHWjG4vKXHHoA1jUPtLnp63PN1sBis5jOyot8nnLB5YL+nniTTeLrwXiETqKh5UwSSmW4ix2mQ5B7oH8ECrS3tEPgQEE+oTHn+WgIMR++sJepCvvlFvcHCJD+axjyD7G6g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b2785e-0052-4c2e-e511-08d70f41e194
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 07:46:32.7077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stephen.twiss@diasemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya Wolfram,

On 22 July 2019 19:26, Wolfram Sang wrote:

> To: linux-kernel@vger.kernel.org
> Subject: [PATCH] mfd: da9063: remove now unused platform_data
>=20
> All preparational patches have been applied, we can now remove the
> include file for platform_data. Yiha!
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/Kbuild                   |  1 -
>  include/linux/mfd/da9063/pdata.h | 60 --------------------------------
>  2 files changed, 61 deletions(-)
>  delete mode 100644 include/linux/mfd/da9063/pdata.h

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
