Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F99C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0047921897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfICCDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:03:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:63124 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfICCDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:03:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 19:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,461,1559545200"; 
   d="scan'208";a="198669637"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2019 19:03:32 -0700
Received: from [10.226.38.16] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.16])
        by linux.intel.com (Postfix) with ESMTP id D6FDA58040E;
        Mon,  2 Sep 2019 19:03:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: cadence-qspi:add support for
 Intel lgm-qspi
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, jwboyer@gmail.com,
        boris.brezillon@free-electrons.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, vigneshr@ti.com,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20190827035827.21024-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190827035827.21024-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <5d6d1b85.1c69fb81.96938.0315@mx.google.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <c2f2dd6f-9553-c9c0-94bf-200684c5597b@linux.intel.com>
Date:   Tue, 3 Sep 2019 10:03:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d6d1b85.1c69fb81.96938.0315@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

  Thank you for the review and Acked-by.

On 2/9/2019 9:39 PM, Rob Herring wrote:
> On Tue, 27 Aug 2019 11:58:25 +0800, "Ramuthevar,Vadivel MuruganX"          wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add new vendor specific compatible string to check Intel's Lightning
>> Mountain(LGM) QSPI features enablement in cadence-quadspi driver.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by tag will be updated in next patch-set.

Best Regards
Vadivel
