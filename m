Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC8C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0DE206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbfDRQSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:18:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37000 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbfDRQSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:18:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C60715AB;
        Thu, 18 Apr 2019 09:18:06 -0700 (PDT)
Received: from e120077-lin.cambridge.arm.com (e120077-lin.cambridge.arm.com [10.2.206.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B893B3F557;
        Thu, 18 Apr 2019 09:18:04 -0700 (PDT)
Subject: Re: rseq/arm32: choosing rseq code signature
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     peter maydell <peter.maydell@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
 <CAFEAcA849mmSds9euyvR2uLWqEeA2eedkmcq1O4pT6-S0oK8BA@mail.gmail.com>
 <936773156.261.1555333890988.JavaMail.zimbra@efficios.com>
 <CAFEAcA8YP5vvZpa_5dvv00koupsry9_3x2EB0cjvE6vtoi8sog@mail.gmail.com>
 <71495082.295.1555335441325.JavaMail.zimbra@efficios.com>
 <755179555.1337.1555421945337.JavaMail.zimbra@efficios.com>
 <cecd4a6e-4a36-1785-4f65-486ba3847a06@arm.com>
 <1583901617.467.1555512184036.JavaMail.zimbra@efficios.com>
 <211627248.490.1555515037279.JavaMail.zimbra@efficios.com>
From:   "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=Richard.Earnshaw@arm.com; prefer-encrypt=mutual; keydata=
 mQGiBEjjjXcRBADwG6UA7HMYfwxecIFq6nmNzzRj1bAwt0CSPp56Kbd6kKZofc5WA9RHYRq8
 X00NL0IXhByAJOC3rCU0uJArA/PO5aBh9xO8LGy82FpYQXc1OP7LL+4DLUS/ExPkHh7fBlzP
 2sTzv1FFqwAVMFTPbTzyePmhjEnvXF5PNp5MTL3mlwCgiFB4ZYEG/5PCgUmC4HDF4ImYSCcE
 ANUPwtmP3Rad6DDOJTOijNQJVsPb2xatLQ79TzWK47Cv6OnsgxiyB5VbOHPiuHvvmBNBN3EB
 /3rweNAAsPeMYMnh2L1uI+hQD0Y5tVYdbQohfvZEQGxyrloWRCqjg8nANRLxCmTpKoeMNMS/
 Tl3ayp9gQQO2j4G3CUNTohYKQ1ckA/9YQSn41fO5gFbP6erWv2Rdq7hrIwhiEbJb7VcNck+g
 B7xFZcinu98Y+T2ClJXY/hHKOQdwNWG/3JVw5JWPQ6u3rfRYl6rlwK9Pav8ICfrzNdmiekcE
 xwNnN7C01PE7krOhyuvbuPxyRYe/TUOX8un/+B9ffSktIEYTfXkdb9AohrQrUmljaGFyZCBF
 YXJuc2hhdyA8UmljaGFyZC5FYXJuc2hhd0Bhcm0uY29tPohgBBMRAgAgBQJI4413AhsjBgsJ
 CAcDAgQVAggDBBYCAwECHgECF4AACgkQ13ksTIWEXSSmpgCfZ+QBeZJH3TvWXuZ20E63MdJr
 uMAAnj77Olwjw4wl16griDwLDCatLZN1uQENBEjjjXgQBAD+yyTRclefTl19lP9W1AEB9E32
 VS4Xa1qY9hkYdMNIaXL3VHhqCyyNLIzXigP1gciwjwRdluA+klRODhANWlFzJAdvlb+Ai/61
 Lty1+OCoi3TvHas6n5DNRwxxrUsZ7ZgcM+KxQ4BJcXlpDmH+S8K/0JHHmq2M1h48G6itStS/
 vwADBQQAj0UeskGLotqFc+MOgaFZNyWizz7hFAfiOhFV14jmJ4J27eRwvfP9q5VkoUzqtWd6
 b//e622/5o58/3cuE8ZqanPAZMRtPHDURjlXXk+R30QMGrrCr+rdv+CaNJ/7LeeCACiUW+XQ
 t9DKlcY32DIxjmEOY9XHYzbX8kFIDNMbvYCISQQYEQIACQUCSOONeAIbDAAKCRDXeSxMhYRd
 JOKiAJ9/DGxhFc8QCtOwS0dMAzw0E33B8gCff2w6jKMSQpZfPUeYlWrpGlGeXuE=
Message-ID: <037f9778-ac24-5f0a-4661-194291eaddde@arm.com>
Date:   Thu, 18 Apr 2019 17:18:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <211627248.490.1555515037279.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2019 16:30, Mathieu Desnoyers wrote:
> ----- On Apr 17, 2019, at 10:43 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Apr 17, 2019, at 6:37 AM, richard earnshaw Richard.Earnshaw@arm.com
>> wrote:
>>
>>> On 16/04/2019 14:39, Mathieu Desnoyers wrote:
>>>> ----- On Apr 15, 2019, at 9:37 AM, Mathieu Desnoyers
>>>> mathieu.desnoyers@efficios.com wrote:
>>>>
>>>>> ----- On Apr 15, 2019, at 9:30 AM, peter maydell peter.maydell@linaro.org wrote:
>>>>>
>>>>>> On Mon, 15 Apr 2019 at 14:11, Mathieu Desnoyers
>>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>>>
>>>>>>> ----- On Apr 11, 2019, at 3:55 PM, peter maydell peter.maydell@linaro.org wrote:
>>>>>>>
>>>>>>>> On Thu, 11 Apr 2019 at 18:51, Mathieu Desnoyers
>>>>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>>>>>  * This translates to the following instruction pattern in the T16 instruction
>>>>>>>>>  * set:
>>>>>>>>>  *
>>>>>>>>>  * little endian:
>>>>>>>>>  * def3        udf    #243      ; 0xf3
>>>>>>>>>  * e7f5        b.n    <7f5>
>>>>>>>>>  *
>>>>>>>>>  * big endian:
>>>>>>>>>  * e7f5        b.n    <7f5>
>>>>>>>>>  * def3        udf    #243      ; 0xf3
>>>>>>>>
>>>>>>>> Do we really care about big-endian instruction-ordering for Thumb?
>>>>>>>> It requires (AIUI) either an ARMv7R CPU which implements and sets
>>>>>>>> SCTLR.IE to 1, or a v6-or-earlier CPU using BE32, and it's going to
>>>>>>>> be even rarer than normal BE8 big-endian...
>>>>>>>
>>>>>>> I don't think we care enough about it to look for a trick to
>>>>>>> turn the branch into something else (which would not branch away from the
>>>>>>> udf instruction), but considering this signature will be ABI, it's good to
>>>>>>> be thorough documentation-wise and cover all existing cases.
>>>>>>
>>>>>> I think if you want to document it it would be helpful to
>>>>>> readers to make it clear that this is the ultra-rare
>>>>>> big-endian-instruction-order "big endian Thumb", not the only
>>>>>> moderately-rare little-endian-instructions-big-endian-data
>>>>>> "big endian Thumb".
>>>>>
>>>>> I'm actually very much concerned about environments with big endian
>>>>> data and little endian code. Which gcc compiler flags do I need to
>>>>> use to test it ?
>>>>>
>>>>> I'm concerned about a signature mismatch between what is passed to
>>>>> the rseq system call ("data-endian signature") and what is generated
>>>>> in the code ("instruction-endian signature").
>>>>
>>>> Based on this page:
>>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0360f/CDFBBCHB.html
>>>>
>>>> My understanding is that the situation is as follows (please confirm):
>>>>
>>>> - Prior to ARMv6, you could build and run code that is either big or little
>>>> endian,
>>>>   given you had a matching Linux kernel endianness. Code and data endianness
>>>>   needed
>>>>   to match,
>>>> - Starting from ARMv6, only little endian code is supported. The endianness for
>>>> data
>>>>   access can be changed through bit [9], the E bit, of the Program Status
>>>>   Register,
>>>>   (mixed endianness)
>>>>
>>>> Looking at ARM build options for gcc, it seems you can select either big or
>>>> little
>>>> endian (-mbig-endian or -mlittle-endian (default)) which affects both
>>>> instruction and
>>>> data endianness. So I suspect the -mbig-endian option is really only useful for
>>>> pre-ARMv6.
>>>
>>> -mbig-endian is still correct, even on later architectures.  The linker
>>> gets involved, however, and (using the mapping symbol information) swaps
>>> the code segments to little-endian form (this is why you have to use
>>> .inst rather than .word when inserting instructions, so that the correct
>>> mapping symbols are inserted).
>>
>> So what you're saying is that if I have:
>>
>> void main()
>> {
>>        asm volatile (
>>                        ".arm\n\t"
>>                        ".inst 0xe7f5def3\n\t"
>>                        ".long 0xe7f5def3\n\t");
>> }
>>
>> and compile it with:
>>
>> arm-linux-gnueabihf-gcc -mbig-endian -march=armv6 -c -o arm-big-endianv6.o
>> arm-test-endian.c
>>
>> It's expected that the generated .o will have big endian instructions, matching
>> the endianness of the data, e.g.:
>>
>> hexdump arm-big-endianv6.o
>>
>> [...]
>> 0000030 0a00 0900 80b5 00af f5e7 f3de f5e7 f3de
>>
>> But it's then at the linking stage that the linker will
>> reverse the endianness of the ".inst" (but not .long).
>>
>> Let's see:
>>
>> arm-linux-gnueabihf-gcc -nodefaultlibs -nostdlib -mbig-endian -march=armv6 -o
>> arm-big-endianv6 arm-big-endianv6.o
>> /usr/lib/gcc-cross/arm-linux-gnueabihf/7/../../../../arm-linux-gnueabihf/bin/ld:
>> warning: cannot find entry symbol _start; defaulting to 00000000000001b0
>>
>> hexdump gives me:
>> [...]
>> 00001b0 80b5 00af f5e7 f3de f5e7 f3de c046 bd46
>>
>> So it has not reversed the instruction endianness.
>>
>> What am I doing wrong ?
> 
> It seems to be specific to using armv6 and armv7* with gcc 7.
> gcc 8 seems to indeed reverse the code vs data endianness.
> 
> So we need to figure out whether .inst is the right things to
> do to declare a signature, or if it's better to use ".long"
> which would probably generate an invalid instruction on BE...

If you used .long the value would then be left as data, but tools that
scanned for data in the text segment (some environments forbid this)
would then fault the object as 'impure'.

So using an instruction would be preferable, but on a BE8 image you'll
need to byte-swap the 'value' before comparing it.  Such images will
have EF_ARM_BE8 set in the flags field of the image header.

R.

> 
> Thanks,
> 
> Mathieu
> 
>>
>> I'm using:
>>
>> gcc version 7.3.0 (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04)
>> GNU ld (GNU Binutils for Ubuntu) 2.30
>>
>> Thanks,
>>
>> Mathieu
>>
>>>
>>>>
>>>> For ARMv6+ mixed-endianness, it seems to be a mode that temporarily swap
>>>> endianness
>>>> of load/store instructions for specific memory accesses communicating with DMA
>>>> devices,
>>>> so I don't see any scenario where we can generate a binary that has little
>>>> endian code
>>>> and big endian data. If that is true, then it should be fine to declare the
>>>> signature
>>>> with ".arm .inst" and expect the data endianness to be the same as code
>>>> endianness.
>>>>
>>>> Am I missing something ?
>>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
> 

