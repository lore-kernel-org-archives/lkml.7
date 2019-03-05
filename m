Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEC2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7438C2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfCEPSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:18:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:44830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728504AbfCEPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:18:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59233B86B;
        Tue,  5 Mar 2019 15:18:33 +0000 (UTC)
Subject: Re: [PATCH v2 0/7] perf script python: add Python3 support
From:   Tony Jones <tonyj@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Feng Tang <feng.tang@intel.com>,
        Tom Zanussi <tzanussi@gmail.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
References: <20190302011903.2416-1-tonyj@suse.de>
 <ef75a243-cf15-b763-8aeb-387f105377c6@intel.com>
 <962077f0-71c6-e2e8-7274-875b55470a3e@suse.de>
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
Message-ID: <59f76d80-ed24-dd88-b3ae-baea39f08499@suse.de>
Date:   Tue, 5 Mar 2019 07:18:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <962077f0-71c6-e2e8-7274-875b55470a3e@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 6:53 AM, Tony Jones wrote:
> On 3/5/19 1:55 AM, Adrian Hunter wrote:
> 
>> perf tools link against python2 so have the scripts been tested with python3?
> 
> Not if PYTHON=python3 is specified on the build line.   Yes, of course they were tested.

See below for exporter.  The viewer also works but obviously harder to demonstrate via log.

$ make PYTHON=python3 prefix=/tmp/perf install
$ ldd /tmp/perf/bin/perf | grep python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f90d32c3000)

# /tmp/perf/bin/perf record -o /tmp/perf.data -e cycles,instructions,branches /bin/false
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.017 MB /tmp/perf.data (39 samples) ]

postgres@svr1:~> id
uid=26(postgres) gid=26(postgres) groups=26(postgres)

postgres@svr1:~> ldd /tmp/perf/bin/perf | grep python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f7714156000)

postgres@svr1:~> /tmp/perf/bin/perf script -i /tmp/perf.data -s /tmp/perf/libexec/perf-core/scripts/python/export-to-postgresql.py db1
2019-03-05 07:14:04.243419 Creating database...
This version of PostgreSQL is not supported and may not work.
This version of PostgreSQL is not supported and may not work.
2019-03-05 07:14:05.122981 Writing to intermediate files...
2019-03-05 07:14:05.187927 Copying to database...
2019-03-05 07:14:05.222272 Removing intermediate files...
2019-03-05 07:14:05.222766 Adding primary keys
2019-03-05 07:14:05.714776 Adding foreign keys

postgres@svr1:~> pg_dump -a -t public.comms -t public.dsos db1
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: comms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comms (id, comm) FROM stdin;
0	unknown
1	perf
2	false
\.


--
-- Data for Name: dsos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dsos (id, machine_id, short_name, long_name, build_id) FROM stdin;
0	0	unknown	unknown	
1	1	[kernel.kallsyms]	[kernel.kallsyms]	0621827fb34281c413e26a0c2d6ba1c0abd706b9
2	1	ld-2.26.so	/lib64/ld-2.26.so	bca321ae4ce1ab788b186e2085f60c1c9723cc14
\.


--
-- PostgreSQL database dump complete
--
