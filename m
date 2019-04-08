Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CBBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534A320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDHMBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:01:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38947 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:01:45 -0400
X-Originating-IP: 90.63.246.187
Received: from gandi.net (lmontsouris-657-1-214-187.w90-63.abo.wanadoo.fr [90.63.246.187])
        (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 26ECA1C0013;
        Mon,  8 Apr 2019 12:01:38 +0000 (UTC)
Date:   Mon, 8 Apr 2019 14:01:38 +0200
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <20190408120138.GA951@gandi.net>
References: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
 <20190328123428.GF7094@linux.intel.com>
 <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jarkko,

On Thu, Mar 28, 2019 at 09:34:18AM -0700, Tadeusz Struk wrote:
> On 3/28/19 5:34 AM, Jarkko Sakkinen wrote:
> > Thank you, it is applied.
> 
> Thank you Jarkko.

What's the status of this patch now? It's needed in linux-5.0.y as TPM
2.0 support is currently broken with those stable kernels without this
commit.

Thanks,

-- 
Thibaut
