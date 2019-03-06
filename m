Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C4F206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfCFQct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:32:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:35522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbfCFQcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:32:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8447ABDF1;
        Wed,  6 Mar 2019 16:32:46 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] perf script python: add Python3 support to sql
 scripts
To:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-7-tonyj@suse.de>
 <7353b42e-ea14-e044-adfe-5a9705bf030c@intel.com>
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
Message-ID: <72ea2e3d-1b82-549e-741f-d2b532e4c33b@suse.de>
Date:   Wed, 6 Mar 2019 08:32:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7353b42e-ea14-e044-adfe-5a9705bf030c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 1:26 AM, Adrian Hunter wrote:
> On 2/03/19 3:19 AM, Tony Jones wrote:
>> Support both Python2 and Python3 in the exported-sql-viewer.py,
>> export-to-postgresql.py and export-to-sqlite.py scripts
>>
>> There may be differences in the ordering of output lines due to
>> differences in dictionary ordering etc.  However the format within lines
>> should be unchanged.
>>
>> The use of 'from __future__' implies the minimum supported Python2 version
>> is now v2.6
>>
>> Signed-off-by: Tony Jones <tonyj@suse.de>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> 
> Apart from one issue (see below), it looks good, thank you!
> 
>> ---
>>  tools/perf/scripts/python/export-to-postgresql.py | 65 +++++++++++++++--------
>>  tools/perf/scripts/python/export-to-sqlite.py     | 23 ++++----
>>  tools/perf/scripts/python/exported-sql-viewer.py  | 42 ++++++++++-----
>>  3 files changed, 84 insertions(+), 46 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
>> index 390a351d15ea..439bbbf1e036 100644
>> --- a/tools/perf/scripts/python/export-to-postgresql.py
>> +++ b/tools/perf/scripts/python/export-to-postgresql.py
>> @@ -10,6 +10,8 @@
>>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>  # more details.
>>  
>> +from __future__ import print_function
>> +
>>  import os
>>  import sys
>>  import struct
>> @@ -199,6 +201,16 @@ import datetime
>>  
>>  from PySide.QtSql import *
>>  
>> +if sys.version_info < (3, 0):
>> +	def tobytes(str):
>> +		return str
>> +else:
>> +	def tobytes(str):
>> +		# Use latin-1 (ISO-8859-1) so all code-points 0-255 will result
>> +		# in one byte (note utf-8 is 2 bytes for values > 128 and
>> +		# ascii is limited to values <= 128)
>> +		return bytes(str, "ISO-8859-1")
> 
> Probably this should be the server_encoding, but python2 allowed UTF-8
> so let's just use UTF-8 for now.  That will also mean doing the conversion
> before getting the len(), otherwise len() can be wrong.

I'm not totally understanding what you're saying here.  The rationale for 
using latin-1 and not UTF-8 was clearly expressed in the comment.  Else you 
do indeed run into length issues.

Would it be easier, since you have a) more familiarity with the code b) some
specific issues I'm not fully understanding if you just took this patch and
made the changes you want yourself.  I doubt I'll ever use these scripta, my
interest is purely in eliminating Python2 as a fixed requirement.

Tony
