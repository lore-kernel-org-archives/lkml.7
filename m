Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464FDC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C10E20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfCZJri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:47:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64148 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbfCZJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:47:37 -0400
X-IronPort-AV: E=Sophos;i="5.60,271,1549900800"; 
   d="scan'208";a="57730665"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Mar 2019 17:47:35 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C13AE4CD5BD8;
        Tue, 26 Mar 2019 17:47:30 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 26 Mar 2019 17:47:36 +0800
Date:   Tue, 26 Mar 2019 17:46:42 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <rppt@linux.ibm.com>, <osalvador@suse.de>, <willy@infradead.org>,
        <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/4] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190326094642.GE4234@localhost.localdomain>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-2-bhe@redhat.com>
 <20190326092324.GJ28406@dhcp22.suse.cz>
 <20190326093057.GS3659@MiWiFi-R3L-srv>
 <20190326093642.GD4234@localhost.localdomain>
 <20190326094348.GT3659@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190326094348.GT3659@MiWiFi-R3L-srv>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: C13AE4CD5BD8.AE87B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:43:48PM +0800, Baoquan He wrote:
>On 03/26/19 at 05:36pm, Chao Fan wrote:
>> On Tue, Mar 26, 2019 at 05:30:57PM +0800, Baoquan He wrote:
>> >On 03/26/19 at 10:23am, Michal Hocko wrote:
>> >> On Tue 26-03-19 17:02:24, Baoquan He wrote:
>> >> > The code comment above sparse_add_one_section() is obsolete and
>> >> > incorrect, clean it up and write new one.
>> >> > 
>> >> > Signed-off-by: Baoquan He <bhe@redhat.com>
>> >> 
>> >> Please note that you need /** to start a kernel doc. Other than that.
>> >
>> >I didn't find a template in coding-style.rst, and saw someone is using
>> >/*, others use /**. I will use '/**' instead. Thanks for telling.
>> 
>> How to format kernel-doc comments
>> ---------------------------------
>> 
>> The opening comment mark ``/**`` is used for kernel-doc comments. The
>> ``kernel-doc`` tool will extract comments marked this way. The rest of
>> the comment is formatted like a normal multi-line comment with a column
>> of asterisks on the left side, closing with ``*/`` on a line by itself.
>> 
>> See Documentation/doc-guide/kernel-doc.rst for more details.
>> Hope that can help you.
>
>Great, there's a specific kernel-doc file. Thanks, I will update and
>repost this one with '/**'.

In that file, there is also some sample for a function comment:

Function documentation
----------------------

The general format of a function and function-like macro kernel-doc comment is::

  /**
   * function_name() - Brief description of function.
   * @arg1: Describe the first argument.
   * @arg2: Describe the second argument.
   *        One can provide multiple line descriptions
   *        for arguments.
   *
   * A longer description, with more discussion of the function function_name()
   * that might be useful to those using or modifying it. Begins with an
   * empty comment line, and may include additional embedded empty
   * comment lines.
   *
   * The longer description may have multiple paragraphs.
   *
   * Context: Describes whether the function can sleep, what locks it takes,
   *          releases, or expects to be held. It can extend over multiple
   *          lines.
   * Return: Describe the return value of function_name.
   *
   * The return value description can also have multiple paragraphs, and should
   * be placed at the end of the comment block.
   */


Anyway, I think you can get more information in that document.

Thanks,
Chao Fan

>
>


