Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31080C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9402168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557862260;
	bh=cyXxdgq0F2t90JBOcGzbeklzMW8c+K7Ei2TXT3ToKrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZtRc1aoSOQCBzohBwxCqCzsKnI4xZ10iMv8Zq/zDYDO9ZKlwC78JQK2zTIaso0MnM
	 FmrDew6LBjarlfKxFzmnjyRu3uSaQNAf/hLNUwOaIPrfD8glOLmr2yU+Ycq+BoJAMz
	 szePcBcQki0EjI1wQNSERPKZpE4ehKDc5pscsPAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfENTa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfENTa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:30:58 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88E72166E;
        Tue, 14 May 2019 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557862258;
        bh=cyXxdgq0F2t90JBOcGzbeklzMW8c+K7Ei2TXT3ToKrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpNFZy533it3ZIsnDGBCnls8/TxWyoZvg3cM5MFnPQRONBnReOpNFJqy9e+BQNWz7
         x+2ZOkPwj0eQX18pfHivmlgzxFY7xQrWV1imJqKlSzwgnb7oHaWK01am/xSQycoPyI
         +YL3b62XR0rli8g+FabtK/NNsDkB6fqFe3snFFFY=
Date:   Tue, 14 May 2019 15:30:56 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Message-ID: <20190514193056.GN11972@sasha-vm>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190507174020.GH1747@sasha-vm>
 <20190508124436.GE7642@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190508124436.GE7642@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 03:44:36PM +0300, Jarkko Sakkinen wrote:
>On Tue, May 07, 2019 at 01:40:20PM -0400, Sasha Levin wrote:
>> On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
>> > From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
>> >
>> > Changes since v2:
>> >
>> > - Drop the devicetree bindings patch (we don't add any new ones).
>> > - More code cleanups based on Jason Gunthorpe's review.
>> >
>> > Sasha Levin (2):
>> >  ftpm: firmware TPM running in TEE
>> >  ftpm: add documentation for ftpm driver
>>
>> Ping? Does anyone have any objections to this?
>
>Sorry I've been on vacation week before last week and last week
>I was extremely busy because I had been on vacation. This in
>my TODO list. Will look into it tomorrow in detail.
>
>Apologies for the delay with this!

Hi Jarkko,

If there aren't any big objections to this, can we get it merged in?
We'll be happy to address any comments that come up.

--
Thanks,
Sasha
