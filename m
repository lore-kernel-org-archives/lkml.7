Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FC0C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D7C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="dougbRlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfEWH3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:29:19 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:52310 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWH3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:29:19 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 269D9200CC;
        Thu, 23 May 2019 09:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1558596552; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ju/S+wL2OcAXGoSvJDWSAsd3Xk7WBxZ9ICqLs8QO3/4=;
        b=dougbRlq29X/T7685vGkmNF8H0e99JxKvupXzkBeLsppGSBTAI+ejPeRg8zpFi7mzMbgi+
        mmmftdAF/w1tmxT0omG8iGDBVnDQc8N0s+haP2lqxSOiQXTVkGuCOx9lIgkQbHpNvpY35h
        qhTBuj5iH8d+rX+ZoLe6/YHMOdz7iEenc0f/qNgl4kBGSDCcFTANPMICddzqjR5UkzHNR8
        wx35MdUQhpK0LaLQ8XkipQG+DajX3vjFKzk576TctPhIx1G7Xy1G+d0XXJzglZmK2nrAC6
        piYg6e1Zqgz1BBB+5vwKyGAXOWEAEG37yCik8soR8V8t4cY+XO8eENwOMgyIcg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 05015BEEBD;
        Thu, 23 May 2019 09:29:11 +0200 (CEST)
Message-ID: <5CE64BC7.4010803@bfs.de>
Date:   Thu, 23 May 2019 09:29:11 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Aung <aung.aungkyawsoe@gmail.com>
CC:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: need company for kernel upgrade
References: <5CE53BA9.4070906@bfs.de> <CABC7EG8NiiPycthdfb7Ng3MsxTvmmxk_LjcosM8ZD1F0CnuDFw@mail.gmail.com>
In-Reply-To: <CABC7EG8NiiPycthdfb7Ng3MsxTvmmxk_LjcosM8ZD1F0CnuDFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.06 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-2.96)[99.82%];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         TO_DN_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 23.05.2019 00:31, schrieb Aung:
> Hello
> 
> I thought you build a kernel, then using SCP or dd to overwite uImage
> file to replace
> the previous kernel image into the file system, then reboot it. Or are
> you trying to
> upgrade without rebooting? Cheers!
> 

No,
the company i am working for has a custom build arm-board.
We bought the kernel from the assembler but found it has
some problems that need fixing.
Basically we want to improve the linux-kernel so it can run
native on our boards.

re,
 wh


> Sincerely
> 
> Aung
> 
> On 5/22/19, walter harms <wharms@bfs.de> wrote:
>> the list was silent but NTL.
>>
>> Hi developers,
>> i am in search of a company that can help upgrading
>> a running linux-kernel on custom hardware.
>> Est. time 10 days.
>>
>>
>> The problems are already identified, we are aiming
>> the get the current vanilla linux kernel on the system.
>>
>>
>> re,
>>  wh
>>
>> _______________________________________________
>> linux-arm mailing list
>> linux-arm@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm
>>
