Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F08C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E763A206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfDZLGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:06:13 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDZLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:06:13 -0400
Received: from [192.168.1.110] ([95.117.100.117]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFbFW-1hZuaM0ohC-00H6I9; Fri, 26 Apr 2019 13:06:00 +0200
Subject: Re: [PATCH] mod_devicetable.h: reduce sizeof(struct of_device_id) by
 80 bytes
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>
Cc:     Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <62959593-6029-e66e-ebee-314db7aa6f10@metux.net>
Date:   Fri, 26 Apr 2019 13:05:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xAHKBzNkH5dQRMa5vm6XP6kXAmIjZcyXPv07AcL8d1eJs8+bcCw
 Yi4iT6pRljUyZ7eSvUVoqaezREp58q+riYBqOosxo5qAGQrx4IviHOvVSB5uBHm1X9635xn
 0KupHe2UpAgnQYbl/fUnacfTIRCpAMxYo4F5sjbz30060omP8bCIKiAKi/xZBSBPzujOFNN
 5/cA2vbqT3VOb5zBQjTlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GS6iPp9pRi4=:xxoBiSkHGi5cmhxL7nzIGt
 1KLVisa+pqTl2oSJBJqwLnz+t6F8Ft5yiVL4HGTowbrY07/TT9sMxZLzSEo4SqS7QMmu6CCB4
 Ww2aNi+GjJWO30xcjmOX5Hq3wAVH+7SaV7RerUFkZsDBXCgpmzfHSM9aHSqsFQz5V2t6kPlIO
 8IiK7qkhGjBB3ex8KXj6He8zau/pvR8fG6QE5PabZ3aj6l+FMrrQy94qUtnVl133U0LYyU3B3
 blw6qByAK8QlUV6ZEAZgq0FgCoo9dsRNDrPuc+X8dJyMNCgtpZnvTSobn2d9O/3YE+aLMIFHn
 +tne7c4BQpPCvSZAwnJbalWen9egUqV4J+WeXKMzBY9rkMjbssifzr7vVzqRfA1BVPtzjro4E
 wcenAL+w+0Vf3DJVSjNXyoW0KSZEF6g6YT56j7AOgJL1X0SCpeFcNsfJ6FpizV2sw3E38B2nM
 jNb82aC4NlkCtpwT4SanPF4QIyzAe/AEkSbvnSgGv7F0m8uQ3CXnpUFLEFgzQcj7Nlf9sc6Gx
 TaayJ3S5OjRqa6SFS1+7D54P+JLtQBUbDarO7PVGihyUXC6hzRR7eVPKw6MYO6VZValarzEzM
 BmFd7tm8tmKQu2vXxevLXi+3JtaYVSGq0ijzXdBxmii7Fx9TZazrgjSFYiKT67k0j3MG/MgcF
 EsXSwWxe/vb3RL4/Lg80A2fUGspaV0sN+W83enwcJ1QGJVn9bk1Wel5FaCPGEJ0Y70GO8RSoY
 UVCfhlrAIgvwOf/ucYpEkRmh+G5EbekofoWsufgiRUL+TJXJE6XaNhsjxbc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.19 22:31, Rasmus Villemoes wrote:

Hi,

> A typical kernel image has hundreds of static struct of_device_id
> instances (a lot of which are sentinel all-zeroes), each occupying
> ~200 bytes. Nobody initializes the .compatible member with strings
> anywhere near 128 bytes, so a lot of that memory is simply wasted.

I just wonder whether it has to be a fixed size array at all, instead
of an const char* pointer. Using a pointer should, IMHO, offer even
more savings while not having the size limit at all.

Is that struct copied as-is somewhere ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
