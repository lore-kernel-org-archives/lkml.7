Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2706C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB3723697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfICOVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:21:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:49145 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfICOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:21:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 07:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="184765156"
Received: from mloktyuk-mobl.amr.corp.intel.com (HELO [10.251.152.40]) ([10.251.152.40])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 07:21:52 -0700
Subject: Re: [alsa-devel] [PATCH] soundwire: bus: set initial value to
 port_status
To:     Bard liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        Blauciak@alsa-project.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org, bard.liao@intel.com
References: <20190829181135.16049-1-yung-chuan.liao@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f75ff0ea-efe1-def5-3fcf-1e90a817234c@linux.intel.com>
Date:   Tue, 3 Sep 2019 08:54:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829181135.16049-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/19 1:11 PM, Bard liao wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> port_status[port_num] are assigned for each port_num in some if
> conditions. So some of the port_status may not be initialized.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>   drivers/soundwire/bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index f6a1e4b4813d..33f41b3e642e 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -835,7 +835,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
>   static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>   {
>   	struct sdw_slave_intr_status slave_intr;
> -	u8 clear = 0, bit, port_status[15];
> +	u8 clear = 0, bit, port_status[15] = {0};
>   	int port_num, stat, ret, count = 0;
>   	unsigned long port;
>   	bool slave_notify = false;
> 
