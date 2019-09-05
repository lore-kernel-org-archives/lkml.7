Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2DAC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBBD206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfIEF0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:26:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34162 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEF0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:26:44 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x855QZIP019987, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x855QZIP019987
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 5 Sep 2019 13:26:35 +0800
Received: from RTITMBSVM03.realtek.com.tw ([fe80::e1fe:b2c1:57ec:f8e1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Thu, 5 Sep
 2019 13:26:34 +0800
From:   Max Chou <max.chou@realtek.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     alex_lu <alex_lu@realsil.com.cn>, Max Chou <max.chou@realtek.com>
Subject: =?big5?B?pl6mrDogW1BBVENIXSBCbHVldG9vdGg6IGJ0cnRsOiBGaXggYW4gaXNzdWUgdGhh?= =?big5?B?dCBmYWlsaW5nIHRvIGRvd25sb2FkIHRoZSBGVyB3aGljaCBzaXplIGlzIG92ZXIg?= =?big5?Q?32K_bytes?=
Thread-Topic: [PATCH] Bluetooth: btrtl: Fix an issue that failing to
 download the FW which size is over 32K bytes
Thread-Index: AdVjqntCvzeidYOQmk+GP6Vie4JmjA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Thu, 5 Sep 2019 05:26:34 +0000
Message-ID: <805C62CFCC3D8947A436168B9486C77DEE3AAA84@RTITMBSVM03.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.83.214]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWF4IENob3Ugp8ax5qZepqyzb6vKtmyl8yBbW1BBVENIXSBCbHVldG9vdGg6IGJ0cnRsOiBGaXgg
YW4gaXNzdWUgdGhhdCBmYWlsaW5nIHRvIGRvd25sb2FkIHRoZSBGVyB3aGljaCBzaXplIGlzIG92
ZXIgMzJLIGJ5dGVzXaFD
