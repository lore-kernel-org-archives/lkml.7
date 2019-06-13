Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E374C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C2B20896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="jeHfwvcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfFMPIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:08:46 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:7748 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732376AbfFMN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:59:42 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 61/82-30864-AC6520D5; Thu, 13 Jun 2019 13:59:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRWlGSWpSXmKPExsWSoc9nqXsqjCn
  WoPU0q8XUh0/YLH5OmsZicf/rUUaLb1c6mCwu75rD5sDqsXPWXXaPTas62TzuXNvD5vHs9iIW
  j8+b5AJYo1gz85LyKxJYM/ZduM1SsJ6tYkXLftYGxiVsXYxcHCwCJ5glpm9oBHOEBCYwSXy4u
  YsFwrnPKLFqz36mLkZODjYBQ4l5b94zgtgiAhkS/zp6GUGKmAUOMEpM6lrIDpIQFgiWuHxgKV
  RRiMSszn2sELaRxMO3R8EGsQioSuzeB1HDKxArcf/SPaBtHEDbLCWWtsmDhDkFrCQWXFwC1so
  oICvxpXE1M4jNLCAucevJfLAxEgICEkv2nGeGsEUlXj7+B1UfL9G+/y07RFxH4uz1J4wQtqLE
  sp1PoeplJS7N74aK+0p8PbgF7BcJgVuMEtOXTYJKaEn0ftjGCmHnSDR8Ws4OcqeEgJrEwqlRE
  GEZiY6vf6F29bJJ7L2qBGILCSRLfJh7FiouJ7Gq9yELxPwLzBKre+aygsxhFtCUWL9LfwKj1i
  wkr81CyECEFSWmdD9knwUOLEGJkzOfsCxgZFnFaJFUlJmeUZKbmJmja2hgoGtoaKRraGmha2h
  koZdYpZukl1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokRmKZSCo417GDsPPBa7xCjJAeTkihv
  xFbGWCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvOWeTLFCgkWp6akVaZk5wJQJk5bg4FES4c0PB
  UrzFhck5hZnpkOkTjEac0x4OXcRM8eRuUsXMQux5OXnpUqJ824AKRUAKc0ozYMbBEvllxhlpY
  R5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ87qCTOHJzCuB2/cK6BQmoFNCdv+LATqlJBEhJdXAtOf
  2nDCbu0Ehn52472QonvR7EGp4s25KtP/RwwtmRRWXZIX9bnP08P2y8nFJ6jrBe152e5b/mOV4
  8LFzqZVjzqbU1pYpF+8VpCk0R3eLNPIw/HfJ8v5uNSO68bXkQ+Ptd1Rm/Dm1JpZ1v2hc/I63o
  Smpmsy3olxtn1fWnvOZan6De1+a/e6DrbX/lPTO9BpVLdwYaNJyWt+9dLLRBpvM55+WTD3+e5
  Gxm1LAwYS8MLmrjM0OpXbhrx/4Jy4sYzmSzmtj+n5aVF9m5+6P+f+Vz0keEeS+bc8w8fRuy9/
  RvUf6S/Jc9jVkLH57+9664/m6a90mSH74ytwx/V/v66Sbv6Q+yJu8+fzpWOSTcocVSizFGYmG
  WsxFxYkAmCMp5mAEAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-6.tower-288.messagelabs.com!1560434377!343123!1
X-Originating-IP: [104.47.14.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16002 invoked from network); 13 Jun 2019 13:59:38 -0000
Received: from mail-vi1eur04lp2057.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.57)
  by server-6.tower-288.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Jun 2019 13:59:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2YeV6QR+Q2CFSyEKApgIWXQqlKeM9j+lMYza3JkDDc=;
 b=jeHfwvczIFzxa2yw4P+nJzBhVrdkIBrwoVcC6dfJai0FXdGXN6/rVcCr3pjS3plzPtplSIXNfEKE+UM7SUUCHYoavgedWe+aUc7L6dbE4e7P+Mt6N47HcufEVQ3p7Sd+1VaDZWt6MsxxPfCjusXNm5dbDxNbI8ariRepQxYc0N0=
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM (20.177.113.222) by
 AM6PR10MB3112.EURPRD10.PROD.OUTLOOK.COM (20.179.3.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 13:59:33 +0000
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4561:9d63:48fa:a882]) by AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4561:9d63:48fa:a882%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 13:59:33 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Felix Riemann <Felix.Riemann@sma.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] regulator: da9062: Adjust LDO voltage selection minimum
 value
Thread-Topic: [PATCH] regulator: da9062: Adjust LDO voltage selection minimum
 value
Thread-Index: AQHVIegnySQaEkg2rkmYypP32O58i6aZmuWw
Date:   Thu, 13 Jun 2019 13:59:33 +0000
Message-ID: <AM6PR10MB2181F17B2265BEE8EB80EC21FEEF0@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
References: <20190613130058.10480-1-felix.riemann@sma.de>
In-Reply-To: <20190613130058.10480-1-felix.riemann@sma.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [62.208.38.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9131647d-c4d4-40cd-21f3-08d6f0075cd4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB3112;
x-ms-traffictypediagnostic: AM6PR10MB3112:
x-microsoft-antispam-prvs: <AM6PR10MB3112DAC7D9DAF6E8CEDD51E4F5EF0@AM6PR10MB3112.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(8936002)(4744005)(25786009)(26005)(52536014)(256004)(66946007)(5660300002)(73956011)(64756008)(66446008)(33656002)(66556008)(66476007)(76116006)(71200400001)(71190400001)(2906002)(102836004)(4326008)(68736007)(76176011)(9686003)(86362001)(2501003)(8676002)(186003)(81166006)(81156014)(53546011)(6506007)(316002)(229853002)(486006)(476003)(11346002)(107886003)(7736002)(6436002)(305945005)(6116002)(54906003)(110136005)(7696005)(99286004)(55016002)(446003)(74316002)(478600001)(14454004)(53936002)(66066001)(3846002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB3112;H:AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E7RMD3yya/MacqFoSdL3YTl7LJN7laKsOiDCBjtQK2GrxpgQBlwl2gGVKrb75AkUBl9KV2CQa/BHiAy4kKxX+q5rYFh/3eqHyniJdaQ50K9RL7Hdh3XR87RmzDdXBUwmDyhMNvQIC7cY+b4BdvxAE6NeZiN9ZnkMP4WuNPInbIMYuLhbwPYvJh96Dg7Nf01ggaA6tBUCLtNUqTbGVmTuxhVZyf7v1I+TIOoXHxEVJ6SvdKO5PalmyaLd33p4i1SM0KqZvLdKIoOUVqQNEnhljlUBXlpluFW2OdJz8r2vFCnigZUwd+5wyxQ30qdYyR9q+axQsDa+YWpqHWPOSAPZf/7YVTfRMFY7TG2XNyw3A5QQVxDOyHZ+mi/QH2ZJ5epc3BntEYUIO0H++6cALMyzL4sSZU74dPRLFBkYDdvNS74=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9131647d-c4d4-40cd-21f3-08d6f0075cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 13:59:33.1847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stephen.twiss@diasemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXgsDQoNCk9uIDEzIEp1bmUgMjAxOSAxNDowMiwgRmVsaXggUmllbWFubiB3cm90ZToN
Cg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHJlZ3VsYXRvcjogZGE5MDYyOiBBZGp1c3QgTERPIHZvbHRh
Z2Ugc2VsZWN0aW9uIG1pbmltdW0gdmFsdWUNCj4gDQo+IEFjY29yZGluZyB0byB0aGUgZGF0YXNo
ZWV0IHRoZSBMRE8ncyB2b2x0YWdlIHNlbGVjdGlvbiByZWdpc3RlcnMgaGF2ZQ0KPiBhIG1pbmlt
dW0gdmFsdWUgb2YgMHgyLiBUaGlzIG9mZnNldCB3YXMgbm90IG9ic2VydmVkIGJ5IHRoZSBkcml2
ZXIsDQo+IGNhdXNpbmcgdGhlIExETyBvdXRwdXQgYmVpbmcgdHdvIHN0ZXBzICg9IDAuMVYpIGxv
d2VyIHRoYW4gcmVxdWVzdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggUmllbWFubiA8
ZmVsaXgucmllbWFubkBzbWEuZGU+DQoNClVoLg0KDQpUaGF0IGxvb2tzIHJpZ2h0LiBCdXQgSSB3
YW50IHRvIHRha2UgYSBjbG9zZXIgbG9vayB0b21vcnJvdyBhbG9uZyB3aXRoIG15DQp0ZXN0cywg
d2hpY2ggbXVzdCBwYXNzIHRoaXMgYmVoYXZpb3VyLg0KDQpHaXZlIG1lIGEgZGF5IG9yIHR3byBw
bGVhc2UuDQoNClJlZ2FyZHMsDQpTdGV2ZQ0KDQoNCg==
