Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DDEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EB9205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKVRiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:38:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:28062 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:38:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 09:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="238682996"
Received: from sygreen1-mobl4.amr.corp.intel.com (HELO [10.252.195.68]) ([10.252.195.68])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2019 09:38:43 -0800
Subject: Re: [alsa-devel] [RESEND PATCH v12 1/6] ASoC: amd:Create multiple I2S
 platform device endpoint
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        Akshu.Agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1574415866-29715-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574415866-29715-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b103e8ea-b5a0-61c6-da51-7c79bb3e4ac9@linux.intel.com>
Date:   Fri, 22 Nov 2019 09:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1574415866-29715-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/19 3:44 AM, Ravulapati Vishnu vardhan rao wrote:
> Creates Platform Device endpoints for multiple
> I2S instances: SP and  BT endpoints device.
> Pass PCI resources like MMIO, irq to the platform devices.
> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

I only saw only a minor nit-pick on return values, so for the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Additional eyes on the code would be desirable before merging though.
