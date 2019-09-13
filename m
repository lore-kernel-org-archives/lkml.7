Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42160C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9EF20650
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfIMRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:55:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:58934 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfIMRz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:55:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 10:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,501,1559545200"; 
   d="scan'208";a="185179047"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2019 10:55:56 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.103]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.66]) with mapi id 14.03.0439.000;
 Fri, 13 Sep 2019 10:55:56 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC:     Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>
Subject: RE: [PATCH 0/7] Address most issues when building with W=1
Thread-Topic: [PATCH 0/7] Address most issues when building with W=1
Thread-Index: AQHVakKk9KcXjUVwg0uJy6Jh5XeXhqcqWRUA//+LOOA=
Date:   Fri, 13 Sep 2019 17:55:55 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F460ABA@ORSMSX115.amr.corp.intel.com>
References: <cover.1568385816.git.mchehab+samsung@kernel.org>
 <20190913175320.GD4190@zn.tnic>
In-Reply-To: <20190913175320.GD4190@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWU2ZDkxNTEtZDdkNC00NzcyLTk5YzEtYWQ5MTg3MjliZGIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieVwvd0JIXC81eTdVOUR1a3dZbTF3bTZLdEdtdGF2Rmxhc1pPM2prRXA0UkhZYnhOQXlha1lFRG1rUEF1M3MxOElaIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMb29rcyBvayB0byBtZSBhdCBhIHF1aWNrIGdsYW5jZSwgQUNLLg0KDQpNZSB0b28uIEFsc28g
QUNLLg0KDQotVG9ueQ0K
