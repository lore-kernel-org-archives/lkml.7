Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F74C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE92217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="g4CmfVEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfC2LB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:01:28 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:46712 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729425AbfC2LB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:01:26 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 34/5F-17148-20BFD9C5; Fri, 29 Mar 2019 11:01:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSW0wTURCGObvbZVUWDwXCgMLDJqhBWymG0Gp
  ieNImeA3yYiC6wNo2aQu2JaIvVoOKFwRMxFAoFKONqUEJ8Y4BRSSi4gUQFVFE0QheIIqK1Ijd
  blV82fxzvv8/M2czDCnvp2MYodAmWMy8kaNnUvrFoUsVhNeZmXi3IVp9dHCIVg98vYnU33qKC
  XX3lWpafX74E6E+fG9lKq297HgerG307Ke1/b1Xae3burOU9ktj3DrZRpnBnJ1XuFmmf9I2Ru
  T3UIV7mm8gOxonD6CZDIXPkjB8bw8lFnJcRsBUdT0tFQMI2n7afcUMhsYqqPkwikQdgTPgyu4
  Jf5zEowhqe1pkIgjH66C8ZF/AtB48pacCOgk+dlSToqZwPDQ0niNEzeIsGJ3YGyx1syN4987l
  BzPwCrhTXBEsaoRjYXzXaX+YxFHQN1Tr9wDGcOLqfVLSkTD8+pdM8m+CfS0fg6XzRdD5eAhJm
  gP3E4dM0rHQVXswcL4aDrkuI3EIwH0Iui8cC4AE6HY/CjQzQkdLVSA8F7zPdsukQLcMKqZ6/U
  COc2DM2RnoHAeekkFKMj0gofX2WOAJi8DV9JmW9EJw170ny9ACx7TXOabZHNNsDv8vC4OOyiH
  KhSgPUmdbDDq9zcQbjApVYqJCpVqiSFIkpyj5HQpeKRQocgSzzcL7oJLfZlVat5tyjLlKs2Br
  RL7tyt1KaC6hhpO6VhTNEFwk+2rCmSkPzc7L3a7nrfpNlgKjYG1FcxmGAzbzh4+FWQSdULjFY
  PSt6B8MTAgXwa4RMWvN501Wg05Ct5GGuXZ80Ekyh7+LX9fTyRpSTpnzzEJMFFsiBrAY0BeY/1
  73Z+m7UGxMOIuCgoLkIfmCxWSw/c9HUBSDuHB22aTvlhCD2fa364hvIMI30MjOKnEgG/8Pxdh
  RpDvtoK0rWuMlssa7bikdyp1Z6WGf8MRwW3u9Js27uSjXeb085Vhe1I3y9Y4FD18Ux1t+paOq
  zKlUbHpZ2ptU+jBC0z5r/ob0zqLJJt3xoMozqe3FofO4FPvauvPs0jlFbrZelcolVzaV1TUf8
  epnZ5xY/rk/OfrNqOHOxVWeKY6y6nlVAmmx8r8BRQOAqu8DAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-24.tower-223.messagelabs.com!1553857281!3326106!2
X-Originating-IP: [104.47.14.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28024 invoked from network); 29 Mar 2019 11:01:22 -0000
Received: from mail-vi1eur04lp2058.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.58)
  by server-24.tower-223.messagelabs.com with AES256-SHA256 encrypted SMTP; 29 Mar 2019 11:01:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+PYyTJxo40SBoMLYhoVoyMh280QwYO8nWynf3miH80=;
 b=g4CmfVEAxQjdjBKfcV9aQ+8+mcswn83kusMWFqpJUjLwtGC/BpM7ZoHziiWl52sAX4hACRIMVeRaaRPVe924wdHbYfcTuvTDBv74WGEhFIvp6iUXUXdCjTwqahQFVbxCsyh3ryIB3srBPe2Tcl/auXOuMhQWWXcR7wxGCDXXS1Y=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM (10.167.201.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 11:01:04 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 11:01:04 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: RE: [PATCH 6/6] regulator: da9063: platform_data is gone, depend on
 OF
Thread-Topic: [PATCH 6/6] regulator: da9063: platform_data is gone, depend on
 OF
Thread-Index: AQHU3aIj9U1ZTqd6vUW62idGwZbaSKYifwMQ
Date:   Fri, 29 Mar 2019 11:01:04 +0000
Message-ID: <VI1PR10MB2352478D42339DE61FF45459FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-7-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-7-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e12f79da-87d7-444e-58ef-08d6b435d665
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0512;
x-ms-traffictypediagnostic: VI1PR10MB0512:
x-microsoft-antispam-prvs: <VI1PR10MB051295B2DAF03BB34078D08AF55A0@VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(8936002)(186003)(256004)(86362001)(68736007)(71190400001)(52536014)(305945005)(3846002)(6116002)(71200400001)(66066001)(7736002)(53546011)(6506007)(55016002)(11346002)(229853002)(316002)(478600001)(486006)(476003)(14454004)(33656002)(76176011)(446003)(106356001)(7696005)(54906003)(53936002)(2906002)(110136005)(105586002)(8676002)(6436002)(4326008)(81166006)(97736004)(81156014)(26005)(5660300002)(99286004)(25786009)(6246003)(4744005)(102836004)(9686003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0512;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6lLl244vG6vpels2m27sy/M0vcLXHeUbt56QXLL30AGJlxSEfOnpjlpsOzUkwO9F9t5ySsig6OeXbAixqTqxlEkvXVAlcHPWfxD/o3jPF7T73z3PKNY4IDhcxo6/zpwfVuLs/AU4hrmPs0W79ELsUfaWXal0+14HPf4lwSOiwzhjZT3KxpZnzjKa5Lyww4ZJRQ9oQY0hH0ggsljZLy1Jhs1EVLwKWwktkcIxldXwNx1giYlNjud6NN4DtGe9yT//oP6Ogn76tJikHChN3a+pjw22+QIEhXm62FfHXmp0reO2MmsSvv5vNssTKyesaTiipLyZ2H9KD5gW9OIgNAnMKZrbKjZCqFu0QYKdizORzPLiQhwhKXOKHNQJrNyYAT5KCME53IOxvZMN+cymU0NKwLdKrYmPNAkbXlMGOdE6eO4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12f79da-87d7-444e-58ef-08d6b435d665
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:01:04.1255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18 March 2019 15:48, Wolfram Sang wrote:

> Subject: [PATCH 6/6] regulator: da9063: platform_data is gone, depend on =
OF
>=20
> With OF being the only configuration possibility left, depend on it to
> simplify some code.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/regulator/Kconfig            |  2 +-
>  drivers/regulator/da9063-regulator.c | 10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
