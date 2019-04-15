Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5DDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4FA2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfDOFm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:42:27 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:45528 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfDOFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:42:26 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 01:42:26 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 61A40161717;
        Sun, 14 Apr 2019 22:34:39 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jpXQdaK0zwDT; Sun, 14 Apr 2019 22:34:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 6788F16171B;
        Sun, 14 Apr 2019 22:34:38 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pq7LZaNzqjVB; Sun, 14 Apr 2019 22:34:38 -0700 (PDT)
Received: from [192.168.1.9] (cpe-23-242-74-103.socal.res.rr.com [23.242.74.103])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id CABB41616C4;
        Sun, 14 Apr 2019 22:34:37 -0700 (PDT)
Subject: Re: bug#35275: spelling mistake manual pages
To:     Vikas Talan <vikas.chaudhary2608@gmail.com>,
        35275-done@debbugs.gnu.org, mtk.manpages@gmail.com,
        majordomo@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-announce@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, libc-alpha-subscribe@sourceware.org,
        libc-help-subscribe@sourceware.org, manpages@packages.debian.org,
        listar@nl.linux.org, linux-man@vger.kernel.org
References: <CABCHxwFMp+vFpv8V-c0=CeXnNmymEuvm_7adGnOnUfCUH7C5+w@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Message-ID: <8970d433-8c7e-23d8-7d04-b9344adbf3ad@cs.ucla.edu>
Date:   Sun, 14 Apr 2019 22:34:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABCHxwFMp+vFpv8V-c0=CeXnNmymEuvm_7adGnOnUfCUH7C5+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That report appears to be about the glibc manual. Please report glibc bugs as 
described here:

https://sourceware.org/glibc/wiki/FilingBugs

Also, please use plain text rather than images to describe bugs in a text file.
