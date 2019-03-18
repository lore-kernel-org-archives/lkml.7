Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B0BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DDD20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="U7jzSI/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCRO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:57:51 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:57053 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:57:50 -0400
IronPort-Data: A9a23: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
 k23QY2uCT80V61+3F6NNREgsQDrps=
X-IronPort-AV: E=Sophos;i="5.58,494,1544511600"; 
   d="scan'208";a="25583715"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Mar 2019 07:57:49 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Mar 2019 07:57:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGoFQLKTP7Hm+ybsDMOzd5lmMkK7lRy43elJPokttA0=;
 b=U7jzSI/L5dpDzmD0S4bVlEuykLsqZmUjrTFPuTVLUkf2rXIH41yRjurBtHG4ktZEccxn9QIUOezdGaTZ4ck1n+5uDWD14LMC8LlSRBc/u2LtQBiCXmAF6Mi4ENiVhrMN7nrMigxzS1DGDDPmkCah/b5fGvyJgBdGtmjP4weCwTA=
Received: from SN6PR11MB3069.namprd11.prod.outlook.com (52.135.126.81) by
 SN6PR11MB2831.namprd11.prod.outlook.com (52.135.93.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 14:57:46 +0000
Received: from SN6PR11MB3069.namprd11.prod.outlook.com
 ([fe80::715e:962d:5745:da26]) by SN6PR11MB3069.namprd11.prod.outlook.com
 ([fe80::715e:962d:5745:da26%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 14:57:46 +0000
From:   <Razvan.Stefanescu@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>
CC:     <webergil@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tty/serial: atmel: RS485 HD w/DMA: enable RX after TX
 is stopped
Thread-Topic: [PATCH 2/2] tty/serial: atmel: RS485 HD w/DMA: enable RX after
 TX is stopped
Thread-Index: AQHU2xDM8sQnzXAFBU2rqYKezse1CKYReDaAgAAHhQA=
Date:   Mon, 18 Mar 2019 14:57:45 +0000
Message-ID: <bec23b27-875a-e78f-48db-2da493360338@microchip.com>
References: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
 <20190315092334.13246-3-razvan.stefanescu@microchip.com>
 <cb09f654-1c42-4f0c-25d3-5cb1708d6080@sorico.fr>
In-Reply-To: <cb09f654-1c42-4f0c-25d3-5cb1708d6080@sorico.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0330.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::30) To SN6PR11MB3069.namprd11.prod.outlook.com
 (2603:10b6:805:d5::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Razvan.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190318165740757
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 843ba1be-d968-42ed-67d6-08d6abb21495
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN6PR11MB2831;
x-ms-traffictypediagnostic: SN6PR11MB2831:
x-microsoft-antispam-prvs: <SN6PR11MB2831C798FA2082961862B0FAE8470@SN6PR11MB2831.namprd11.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(110136005)(54906003)(81156014)(81166006)(316002)(7736002)(52116002)(76176011)(256004)(486006)(476003)(2616005)(11346002)(6506007)(386003)(71190400001)(71200400001)(102836004)(446003)(6246003)(53546011)(99286004)(26005)(186003)(6512007)(6116002)(66066001)(3846002)(229853002)(14454004)(68736007)(305945005)(53936002)(105586002)(31686004)(8676002)(86362001)(25786009)(31696002)(2906002)(8936002)(5660300002)(4744005)(97736004)(6436002)(4326008)(106356001)(478600001)(72206003)(36756003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2831;H:SN6PR11MB3069.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HKd89dy7ayiQWdcCOwNtQaUWdFU3t3t4kzlE/qMJr8105THKd1pHyt+UT053FjqE2L1pZ79hdJ9P3bYuYhY/+jpvyLwv3CiZgyDgWrdwdPIRcfUI+6anAWYMKjeL3JTZAXfUpHW/VO9GaoTsxJqsO0Tnn3LLTTTHKszrdPQj7rYUIJuQxZaMxoZsP1aLxGXdFSdpkCjRYIVJAAsn6GgazBnHExMy2tkXOFN2S+gBNIIV4QtmpvbKsPjg2UnDXeHXpnLkknSajvFp7j8Vccc6O1qXjp/QWkU27mKHOAdD70TzwuerZStrlxiExjeN0MV48DmJdRhSDJUMZFQx9bn3erIsJ+JrXdapZtYNwEII4/zPkuqVfMMRXmSGXrF+NTR4d3l41o9HqQdUx4wz7OvXDwigw2O7SW3YnAHX5bAdPZ0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08EAC9708B34CC49B3AE015CA1DBAF32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 843ba1be-d968-42ed-67d6-08d6abb21495
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 14:57:45.9899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2831
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOC8wMy8yMDE5IDE2OjMwLCBSaWNoYXJkIEdlbm91ZCB3cm90ZToNCj4+ICsJCS8qIFN0
YXJ0IFJYIGlmIGZsYWcgd2FzIHNldCBhbmQgRklGTyBpcyBlbXB0eSAqLw0KPj4gKwkJaWYgKGF0
bWVsX3BvcnQtPmhkX3N0YXJ0X3J4KSB7DQo+PiArCQkJaWYgKGF0bWVsX3VhcnRfcmVhZGwocG9y
dCwgQVRNRUxfVVNfQ1NSKQ0KPj4gKwkJCQkJJiBBVE1FTF9VU19UWEVNUFRZKSB7DQo+PiArCQkJ
CWF0bWVsX3BvcnQtPmhkX3N0YXJ0X3J4ID0gZmFsc2U7DQo+PiArCQkJCWF0bWVsX3N0YXJ0X3J4
KHBvcnQpOw0KPj4gKwkJCX0gZWxzZSB7DQo+PiArCQkJCWRldl93YXJuKHBvcnQtPmRldiwgIlNo
b3VsZCBzdGFydCBSWCwgYnV0IFRYIGZpZm8gaXMgbm90IGVtcHR5XG4iKTsNCj4gV2hhdCB3aWxs
IGhhcHBlbiBpbiB0aGlzIGNhc2UgPw0KPiANCg0KUlggd2lsbCBub3QgYmUgc3RhcnRlZC4gSSBo
YXZlbid0IGJlZW4gYWJsZSB0byB0cmlnZ2VyIHRoaXMgZXJyb3IgY2FzZS4gDQpXb3VsZCBpdCBi
ZSBiZXR0ZXIgdG8gc3RhcnQgUlggYW55d2F5IGFuZCBqdXN0IGRpc3BsYXkgdGhlIGVycm9yIG1l
c3NhZ2UgDQppZiBUWCBmaWZvIGlzIG5vdCBlbXB0eT8gQnV0IHRoaXMgd2F5IGl0IHdpbGwgYmUg
bGlrZSBiZWZvcmUgdGhpcyBmaXgsIA0KaW4gY2FzZSBvZiBhbiBlcnJvci4NCg0KVGhhbmsgeW91
LA0KUmF6dmFuDQo=
