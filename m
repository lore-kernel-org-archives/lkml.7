Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35BAC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3172173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfHHQ3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:29:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:64301 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQ3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:29:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 09:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="203633797"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2019 09:29:19 -0700
Received: from kyablokx-mobl.amr.corp.intel.com (unknown [10.251.19.34])
        by linux.intel.com (Postfix) with ESMTP id 0EA5F58044F;
        Thu,  8 Aug 2019 09:29:17 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: codecs: add wsa881x amplifier
 support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-5-srinivas.kandagatla@linaro.org>
 <3ad15652-9d6c-11e4-7cc3-0f076c6841bb@linux.intel.com>
 <32516aae-8a43-6a74-c564-92dea8ff6e53@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4e60b92f-a32e-671c-3b1b-9b1ccec4f9b5@linux.intel.com>
Date:   Thu, 8 Aug 2019 11:29:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <32516aae-8a43-6a74-c564-92dea8ff6e53@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +/* 4 ports */
>>> +static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>>> +    {
>>> +        /* DAC */
>>> +        .num = 1,
>>> +        .type = SDW_DPN_SIMPLE,
>>
>> IIRC we added the REDUCED type in SoundWire 1.1 to cover the PDM case 
>> with channel packing (or was it grouping) used by Qualcomm. I am not 
>> sure the SIMPLE type works?
> grouping I guess.
> 
> This is a simplified data port as there is no DPn_OffsetCtrl2 register 
> implemented.

ok, for the REDUCED type it's required to have BlockPackingMode and 
OffsetCtrl2, so it does not apply here. Thanks for confirming.
