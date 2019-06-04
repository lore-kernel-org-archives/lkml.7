Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB3208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559661745;
	bh=lVdOfl5mMM4/U7zXe6pA0wVmIgPYM1znQCitNaCM4v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HRBqPKrKMxXo8s/vhWA/Sq0b6Z15Fxmy+sJUcPGvkbLNsFGRIdNooFjc51cu+SWwy
	 wCfIMPV664qn28JauVtyjSvwbz9rzsntouqe3JtZ8uqccWZFxNofRO6sPx/4l4KPk5
	 EfJIvlBTXNF3LdToMN1OPws+4YKUiKsxy/8JlnO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfFDPWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfFDPWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:22:25 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FE420717;
        Tue,  4 Jun 2019 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559661744;
        bh=lVdOfl5mMM4/U7zXe6pA0wVmIgPYM1znQCitNaCM4v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkVMMl/WIfQWlw+qL6ZxV4e9E69F9NBrq0gYloSeEkywgkHXUs1+W1ZSDJB3uoGuh
         KlAeBoVR7W5d0LditCCgg3Qn1FYSDGF3g/Bw8rEUZmN73HgHhyKnxSKerZj5xYfhC5
         4zQ6+osKiscKkdFkxbB02Nqb5NRXuamDafBcb8O4=
Date:   Tue, 4 Jun 2019 20:49:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 13/22] docs: soundwire: locking: fix tags for a
 code-block
Message-ID: <20190604151916.GK15118@vkoul-mobl>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
 <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 11:17, Mauro Carvalho Chehab wrote:
> There's an ascii artwork at Example 1 whose code-block is not properly
> idented, causing those warnings.
> 
>     Documentation/driver-api/soundwire/locking.rst:50: WARNING: Inconsistent literal block quoting.
>     Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
>     Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
>     Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.

Applied, thanks

-- 
~Vinod
