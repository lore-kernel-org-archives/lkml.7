Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD71C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747B2343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567201626;
	bh=LGPd6aGerbg+EQvRvyLkbXiqdmmLuliyIP1+PAbHKZE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ij1NphjI1yaxebhLj0PlkkbIu2j0KSdwc0riXiNSaa8dYwIL72lphGH+Rb2n3e+mM
	 CwQ0gGYbvnbY93cCcrMwp/8uwKRdzf0dAfyTIW6uKYdvhkb5j0y6yncs2479jfov2v
	 7uNiPal1mse2Udz8jIYLamyFuTgi7PScCTK6Qsxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfH3VrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbfH3VrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:47:03 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334982342E;
        Fri, 30 Aug 2019 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567201622;
        bh=LGPd6aGerbg+EQvRvyLkbXiqdmmLuliyIP1+PAbHKZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rp+l4BiAm1yJj9balH6YdcatrsbH55JTvgAaFymAa2f5QMttZN90wffsKUx6E6oTc
         uUuPA1mSrWhLqvdmoWCQMMs3WIfIOrMZ7sy+ow/8/xwwTlJ0m2Lk5V30FSGzPLmfad
         cM2fJRoNj9CwLhYs5KMtI7Eo/DQUunNli505mTys=
Subject: Re: [PATCH] selftest/ftrace: Fix typo in trigger-snapshot.tc
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190803000126.23200-1-standby24x7@gmail.com>
 <20190830173154.467d9335@gandalf.local.home>
From:   shuah <shuah@kernel.org>
Message-ID: <2484ed4e-2a59-07f3-3f00-4ac3d1178621@kernel.org>
Date:   Fri, 30 Aug 2019 15:47:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830173154.467d9335@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/19 3:31 PM, Steven Rostedt wrote:
> On Sat,  3 Aug 2019 09:01:26 +0900
> Masanari Iida <standby24x7@gmail.com> wrote:
> 
>> This patch fixes a spelling typo in tigger-snapshot.tc
>>
> 
> As Randy said: "trigger-snapshot.tc"
> 
> Shuah, can you take this?
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 

Done. Applied with typo fix to the commit log.

thanks,
-- Shuah
