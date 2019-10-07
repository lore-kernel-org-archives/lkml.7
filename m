Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0405DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB44D217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570435969;
	bh=lDHYlNBMrFTJ7feRS2e/rWmF8aTUiIwX0TrGjMUBAaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lP/XhtfhzH5wLp+8w0aHq71Vcwam2602Mvtj1t8PG4rDQ5G3LmvyfTp4SSusMM73y
	 P7RxiU/rty9+6LWETWKp5ScD9AK6aabAKYQpEgDM1S3SZZms2KGVzB3yHmG/F/wNRI
	 TRqbAmhVQs4p/FuLZg1wulgF9tcehcgo7xafTTYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfJGIMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfJGIMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:12:48 -0400
Received: from linux-8ccs (unknown [92.117.158.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B07820679;
        Mon,  7 Oct 2019 08:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570435968;
        bh=lDHYlNBMrFTJ7feRS2e/rWmF8aTUiIwX0TrGjMUBAaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbTfHbAmTehDheUjqI9O4e8N74P4tcp6iepV4UTF2QAUw6k0M37bBtby2Zn0ZK7vF
         0k/+gB8yDIWB2P3ZTSux0sdEIh2vjXpGCl0y6wLkCpBVGumh9u26ziE5S9QwlbdYh8
         axlTBx9kx/nzYstZgb0OipNCOXrutzsuXA9cPC9E=
Date:   Mon, 7 Oct 2019 10:12:42 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Adam Zerella <adam.zerella@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: move namespaces.rst out of kbuild directory
Message-ID: <20191007081241.GA8279@linux-8ccs>
References: <20191007043611.31036-1-yamada.masahiro@socionext.com>
 <20191007060614.GA142813@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191007060614.GA142813@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Maennich [07/10/19 07:06 +0100]:
>Hi!
>
>On Mon, Oct 07, 2019 at 01:36:11PM +0900, Masahiro Yamada wrote:
>>I did not notice this document was added to Documentation/kbuild/,
>>and I do not understand how it is related to the build system.
>>
>>Kick it out of the kbuild directory.
>>
>>I am not sure if this is the perfect place, but I added its index
>>close to the module-signing.
>
>When searching for a place for this documentation, kbuild/ was the
>closest I could find. admin-guide/ seems to target system administrators
>while the symbol namespace feature documentation is relevant for kernel
>developers. I am ok to take maintainership for the file, but the new
>location suggested seems not to be a good fit either.

This was my line of thought as well, since the audience of
admin-guide/ is sysadmins and users. Namespaces are mostly relevant to
module authors and kernel developers. Currently, I don't think there
is an existing good place in Documentation/ for this topic :-/
I suppose kernel-hacking/ might be the closest fit, as Adam suggested.

Thanks,

Jessica
