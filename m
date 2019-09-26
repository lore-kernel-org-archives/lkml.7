Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF9CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbfIZB4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:56:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfIZB4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:56:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31727B659;
        Thu, 26 Sep 2019 01:56:12 +0000 (UTC)
Subject: Re: [PATCH 1/2] perf script python: integrate page reclaim analyze
 script
To:     Yafang Shao <laoar.shao@gmail.com>, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, akpm@linux-foundation.org,
        jolsa@redhat.com, mingo@redhat.com
Cc:     linux-mm@kvack.org, florian.schmidt@nutanix.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org
References: <1568817522-8754-1-git-send-email-laoar.shao@gmail.com>
 <1568817522-8754-2-git-send-email-laoar.shao@gmail.com>
From:   Tony Jones <tonyj@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QaVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5kZT6IYAQTEQIAIAUCSRCZvAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheAAAoJELFYWyEf4koXGmYAoKCnbv9dhAB2vR6IvSJem1ws4HpfAJ9ZqTKiXcogBGfTPaJR
 GI9QhVUieLkCDQRJEJm8EAgAzr9Zd3v7B10ODtVc7XxbMe3W6o1FdClL9ZIgLv61zhWctafK
 DMu/MUSvxmYFq00pecD/SfX8oxArA02+sQ2E+/Zb4J7NAWIAxCfmy7VE0wDBrZH/hBapIx/L
 gVqYfZ9Rw+a4FXrlk1y8oQCwhvj+kWrm7V7olR0aPOy1NFGNUyTFSMj+pbmxiNOXdCxVUQe3
 UE1k9yA+mILjyaRanwkiCLCjNvRPL88Q017BdhVBWZmz8qhwXN/RrjCcDHsPX5O0ev68MLyu
 sh5mfukuvCqzW1Y3Ql+iwfwEw5lNmQGdoV9csg7JP7saDicSFO2KcZvMbvDMqtPFipdF5UWo
 fZKZ3wADBQf/b5cVNyb5i8QI0G7BPGBNn4VlQX5n66TsPBnrRNOi3MhTTVEBCp8s+jqUjJjX
 EjjA+O4hIm7Qqdsozurw7GlcQ0A06dIzO/1RUglZZMoC0JL43ZQmJ+3+yFrLjWgGH6ev6AOb
 YLH7ZujgAB5n0Hy2ZIChzsKLKbHptFtBvpDKB8updq+GunsY4oN3wGa67h9sHqDvjyp64Czg
 n8G5uGLwx3f/edbECKz5kPUSzChEk3suK742SEP01v4ra5WX88Hn81NjGByQMz9acJLdC7Ff
 LzXvbNa0KgvDaSllYfsJIoGCz3eKVOuTWXOiaEIKuy833+3mr2PulLCyLKysAEddKohJBBgR
 AgAJBQJJEJm8AhsMAAoJELFYWyEf4koXhgQAn1EGATLZPS53At9t+p3S8BkNI9yRAJ9A0OmL
 liv+rwEesYGlGeGNaKHTJw==
Message-ID: <456c8216-a9f4-6821-e688-744e93df826f@suse.de>
Date:   Wed, 25 Sep 2019 18:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1568817522-8754-2-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/19 7:38 AM, Yafang Shao wrote:
> A new perf script page-reclaim is introduced in this patch. This new script
> is used to report the page reclaim details. The possible usage of this
> script is as bellow,
> - identify latency spike caused by direct reclaim
> - whehter the latency spike is relevant with pageout
> - why is page reclaim requested, i.e. whether it is because of memory
>   fragmentation
> - page reclaim efficiency
> etc
> In the future we may also enhance it to analyze the memcg reclaim.
>
> Bellow is how to use this script,
>     # Record, one of the following
>     $ perf record -e 'vmscan:mm_vmscan_*' ./workload
>     $ perf script record page-reclaim
>
>     # Report
>     $ perf script report page-reclaim
>
>     # Report per process latency
>     $ perf script report page-reclaim -- -p


I tested it with global-dhp__pagereclaim-performance from mmtests and got what appears to be reasonable results and the output looks correct and useful.  However I'm not a vm expert so I can't comment further.  Hopefully someone on linux-mm can give more specific feedback.

There is one issue with Python3,  see below.  I didn't test with Python2.

>
> +	@classmethod
> +	def shrink_inactive(cls, pid, scanned, reclaimed, flags):
> +		event = cls.events.get(pid)
> +		if event and event.tracing():
> +			# RECLAIM_WB_ANON 0x1
> +			# RECLAIM_WB_FILE 0x2
> +			_type = (flags & 0x2) >> 1
> +			event.process_lru(lru[_type], scanned, reclaimed)
> +
> +	@classmethod
> +	def writepage(cls, pid, flags):
> +		event = cls.events.get(pid)
> +		if event and event.tracing():
> +			# RECLAIM_WB_ANON 0x1
> +			# RECLAIM_WB_FILE 0x2
> +			# RECLAIM_WB_SYNC 0x4
> +			# RECLAIM_WB_ASYNC 0x8
> +			_type = (flags & 0x2) >> 1
> +			_io = (flags & 0x4) >> 2
> +
> +			event.process_writepage(lru[_type], sync_io[_io])
> +
> +        @classmethod

Space indentation on line above.  For python3 this results in:

  File "tools/perf/scripts/python/page-reclaim.py", line 217
    @classmethod
               ^
TabError: inconsistent use of tabs and spaces in indentation

> +	def iterate_proc(cls):
> +		if show_opt != Show.DEFAULT:
> +			print("\nPer process latency (ms):")
> +			print_proc_latency(latency_metric, 'pid', '[comm]')
> +
> +			if show_opt == Show.VERBOSE:
> +				print("%20s  %s" % ('timestamp','latency(ns)'))


Thanks

Tony

