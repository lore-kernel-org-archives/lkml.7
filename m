Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F91EC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C90B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="VpuN9r/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfFRMSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:18:36 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:43015 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfFRMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:18:36 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id D7/20-08182-896D80D5; Tue, 18 Jun 2019 12:18:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRWlGSWpSXmKPExsWSoc9hrDvjGke
  swa4FghZTHz5hs/g5aRqLxf2vRxktvl3pYLK4vGsOmwOrx85Zd9k9Nq3qZPO4c20Pm8ez24tY
  PD5vkgtgjWLNzEvKr0hgzbjyqYupYApnxecHZ1kaGFs4uxi5OFgETjBLPDgzjQ3EERKYyCTxb
  udTRgjnPqNE97UXLF2MnBxsAoYS8968ZwSxRQQyJP519IIVMQscYJSY1LWQHSQhLBAscfnAUq
  iiEIlZnftYIWwniel/F7KB2CwCqhI7l/UBxTk4eAViJVZNDYJYdpdR4vi6/cwgNZwCcRJXL+1
  kArEZBWQlvjSuBoszC4hL3HoyHywuISAgsWTPeWYIW1Ti5eN/rBD18RLt+9+yQ8R1JM5ef8II
  YStJLLsxixXClpW4NL8bKu4rce/DfLD3JQRuMUrsX3UYqkhL4viabqhlORIf9rWwQNhqElc/H
  YWyZSR6Dr1mhWjuZZOYfOQlWEJIIFniw9yzUFfISazqfcgCUXSBWaLh2FZ2kPeZBTQl1u/Sn8
  CoNQvJc7MQMhBhRYkp3Q/ZQWxeAUGJkzOfsCxgZFnFaJlUlJmeUZKbmJmja2hgoGtoaKxroGt
  kbKSXWKWbqJdaqpucmldSlAiU1UssL9YrrsxNzknRy0st2cQITFcphQwvdjA+PPJa7xCjJAeT
  kihvUjR7rBBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3rgrHLFCgkWp6akVaZk5wNQJk5bg4FES4
  W0ASfMWFyTmFmemQ6ROMRpzTHg5dxEzx5G5SxcxC7Hk5eelSonzdoGUCoCUZpTmwQ2CpfRLjL
  JSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5M68CTeHJzCuB2/cK6BQmoFMeLWUDOaUkESEl1cA
  0JeUk+90N0/ONbzM8KErIO32esfN/WF9878u0p1LH9C66iquas8yN742KWuyysb5h2mS/pi0M
  /39/OrtS8bD+2ibXjxe/Zy7WPP7O9vvmxKR/p3d4K3zwWZMfvNz8Xvuy8923P9RsmLJxadrzg
  7uVHj7Wn+ppwpjseldshVZgXknmsl1+kl18q1bHGM+56r7g37ZzHBeDkxTmrV13yu3blQN7BF
  ffe/D+BVPs7po1d730+lk1uPZwWd7bfYnVPuBTocYy24P5M/VU6lz2OR8+JeS4tUzr60y3xbV
  bdtVuOXPl/53q/2cNO0UnvJr/9ruOkohzTVRFZkbufTF9nb3WnKHBHg2Gm0/P4C49pvthtxJL
  cUaioRZzUXEiAH5ikeBkBAAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-30.tower-229.messagelabs.com!1560860310!607507!1
X-Originating-IP: [104.47.8.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8966 invoked from network); 18 Jun 2019 12:18:32 -0000
Received: from mail-am5eur03lp2051.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.51)
  by server-30.tower-229.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 18 Jun 2019 12:18:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3gheQsNcOvfgT4FBoQCHjmyxHQvsnMwpbQkAbm3h7I=;
 b=VpuN9r/8vK4a9WuqY2CBytAuhCERhsBjPHvOnAYh580v4b09jB+GNXsBLnzlacSH07IfQwGw7VsMlbgikcEh/Xiy07pQDYDJYTkPPmynpv1naJcOXNNWdXX3jLftpdJL8SAWqtYLFJWQKn6VjxAZovOj+7t137W/S2sB57ZsWL8=
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM (20.177.113.222) by
 AM6PR10MB2407.EURPRD10.PROD.OUTLOOK.COM (20.177.116.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 12:18:27 +0000
Received: from AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4561:9d63:48fa:a882]) by AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4561:9d63:48fa:a882%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 12:18:27 +0000
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
Thread-Index: AQHVIegnySQaEkg2rkmYypP32O58i6aZmuWwgAesEDCAABLgUA==
Date:   Tue, 18 Jun 2019 12:18:27 +0000
Message-ID: <AM6PR10MB2181F670129B7046DFECB378FEEA0@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
References: <20190613130058.10480-1-felix.riemann@sma.de>
 <AM6PR10MB2181F17B2265BEE8EB80EC21FEEF0@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
 <AM0PR04MB54276B6CFB2F8188A5AAA10C88EA0@AM0PR04MB5427.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB54276B6CFB2F8188A5AAA10C88EA0@AM0PR04MB5427.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17af2388-3d9e-449f-385e-08d6f3e71150
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2407;
x-ms-traffictypediagnostic: AM6PR10MB2407:
x-microsoft-antispam-prvs: <AM6PR10MB2407108182F92238233FF84AF5EA0@AM6PR10MB2407.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(73956011)(3846002)(53936002)(55016002)(107886003)(7736002)(66066001)(2906002)(6436002)(4326008)(5660300002)(74316002)(305945005)(110136005)(54906003)(4744005)(71190400001)(2501003)(71200400001)(476003)(68736007)(8676002)(26005)(66446008)(6506007)(33656002)(316002)(64756008)(256004)(81166006)(81156014)(76176011)(11346002)(446003)(486006)(8936002)(52536014)(229853002)(53546011)(86362001)(66476007)(66556008)(102836004)(66946007)(186003)(7696005)(6116002)(14454004)(76116006)(6246003)(99286004)(478600001)(9686003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2407;H:AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: twQ5bSAGssBcxb6xoou9t7qxauDolf2S1UqvBCFQCE7ymjL3t658rJGSAUqpCmGOQsT80TJG568VkL/sQWxJ3G+xqjhgUjgOyj6xJPPdGYYb+XNVDXIBSo2Utg4Yugc2zIKKiF1tfUtjRkP83p4Epac0YOAj4soNqJF9nsvf9LELr/HD3b53Jb96xLdkiGWt7IxScBPCil46EaYBFuHiOsGcaYH+9wD8EyKAM/LIFiFs2SbTbtmMGtsbsYmR0pI2b+RFQfjKC/X8oNqc3IMXX4Jx+NHREbcFj+iOkok5EaX8ZwfEtNE56M/PIHg7N4JQoNzn442+naEFsmWhb5jUC2V33XxbJBpsw8KxrEr9sCuYfTebtZwx9lF77QBPcfmHO0iWFRyVR/oRtlTEPl++YE8y1gAQEv+RDL7HHA3NkNY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17af2388-3d9e-449f-385e-08d6f3e71150
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 12:18:27.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stephen.twiss@diasemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXgsDQoNCk9uIDE4IEp1bmUgMjAxOSAxMjowOCBGZWxpeCBSaWVtYW5uIHdyb3RlOg0K
DQo+IFN1YmplY3Q6IEFXOiBbUEFUQ0hdIHJlZ3VsYXRvcjogZGE5MDYyOiBBZGp1c3QgTERPIHZv
bHRhZ2Ugc2VsZWN0aW9uIG1pbmltdW0gdmFsdWUNCj4gDQo+IEhpIFN0ZXZlLA0KPiANCj4gQSBj
b2xsZWFndWUgdG9sZCBtZSB0aGF0IGhlIHNhdyBvdXIgbWFpbCBzZXJ2ZXIgbWl4LXVwIHdoaXRl
c3BhY2VzIGluIHRleHQgbWFpbHMNCj4gYmVmb3JlLCBhbHRob3VnaCB0aGUgY29weSB0aGF0IGdv
dCByZWxheWVkIGJhY2sgdG8gbWUgbG9va3Mgb2theS4gSXMgdGhlIHBhdGNoDQo+IHVzYWJsZSBv
ciBzaG91bGQgSSB0cnkgdG8gcmVzZW5kIGl0IHRocm91Z2ggYW5vdGhlciBzZXJ2ZXI/DQoNClll
cyB0aGVyZSBpcyBhIGxpdHRsZSBiaXQgb2YgYSB3aGl0ZS1zcGFjZSBtaXgtdXAgaW4gYm90aCBw
YXRjaGVzIC0tIGJ1dCBJIGNvdWxkIHNlZSB3aGF0DQp3YXMgc3VwcG9zZWQgdG8gaGFwcGVuLg0K
DQpJIGZpeGVkIHRob3NlIHRoaXMgbW9ybmluZyBhbmQgSSd2ZSBtYWRlIGEgY291cGxlIG9mIHN1
Z2dlc3Rpb25zLiBCdXQgYmVmb3JlIEkgc2VuZCB0aGUNCnBhdGNoIGJhY2sgKGZvciB5b3VyIGFw
cHJvdmFsKSBJIGFtIGp1c3QgbWFraW5nIHNvbWUgY2hhbmdlcyB0byBteSB0ZXN0cyBzbyBpdCBw
aWNrcyB1cA0KdGhpcyBjaGFuZ2UgaW4gZnV0dXJlLg0KDQpObyBuZWVkIHRvIHNlbmQgaXQgYWdh
aW4sIHRoYW5rIHlvdS4NCk9uY2UgSSd2ZSBtYWRlIGNlcnRhaW4gaXQgZG9lcyB3aGF0IGl0IGlz
IHN1cHBvc2VkIHRvIGRvLCBJIHdpbGwgc2VuZCBmb3IgeW91ciByZXZpZXcuDQoNClJlZ2FyZHMs
DQpTdGV2ZQ0KDQo=
