Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F86C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C60C206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfD1OJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 10:09:07 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:18867
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbfD1OJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 10:09:07 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Apr 2019 10:09:05 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AoAACKsMVc/6CMBjoNWRoBAQEBAQI?=
 =?us-ascii?q?BAQEBBwIBAQEBgWWCeYEshBCTbQEBAQEBAQaBCC2JTIE8j0MzgVWCdQKGVTg?=
 =?us-ascii?q?TAQMBAQEEAQEBAQKBCYVWAQEBAQIBIxVBEAsSBgICJgICSQ4GAQwGAgEBgx4?=
 =?us-ascii?q?BgXQFHqszcYEvhDIBgRSDHYE/BoELJ4theIEHgREngms+hB2DMYJYBIpdgi+?=
 =?us-ascii?q?FXocJjQQIAYILhhGELIdwIYINihyIfokCgwuGQZAagXczGggoCIMnghgDF4h?=
 =?us-ascii?q?ghVFgkQ6CUgEB?=
X-IPAS-Result: =?us-ascii?q?A2AoAACKsMVc/6CMBjoNWRoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?WWCeYEshBCTbQEBAQEBAQaBCC2JTIE8j0MzgVWCdQKGVTgTAQMBAQEEAQEBA?=
 =?us-ascii?q?QKBCYVWAQEBAQIBIxVBEAsSBgICJgICSQ4GAQwGAgEBgx4BgXQFHqszcYEvh?=
 =?us-ascii?q?DIBgRSDHYE/BoELJ4theIEHgREngms+hB2DMYJYBIpdgi+FXocJjQQIAYILh?=
 =?us-ascii?q?hGELIdwIYINihyIfokCgwuGQZAagXczGggoCIMnghgDF4hghVFgkQ6CUgEB?=
X-IronPort-AV: E=Sophos;i="5.60,406,1549900800"; 
   d="scan'208";a="186111761"
Received: from 58-6-140-160.dyn.iinet.net.au (HELO [192.168.0.106]) ([58.6.140.160])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 28 Apr 2019 21:59:40 +0800
Subject: Re: endianness swapped
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190427153222.GA9613@jerusalem>
 <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
Date:   Sun, 28 Apr 2019 23:59:39 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/4/19 7:21 pm, Arnd Bergmann wrote:
> On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
>>> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
>>>> as you may know, i am working on mcf5441x.
>>>> Sorry for not following carefully all the threads, but from a certain
>>>> kernel version (likely 4.19 or near there), seems ioread32be
>>>> reads the bytes swapped in endianness (mcf-edma dma driver not working
>>>> anymore).
>>>>
>>>> Has there been a change about this in the architecture I/O access ?
>>>> How should i proceed now ? Fixing the DMA driver read/write, or what ?
>>
>>> looks like the reason of my ioread32be now swapped is:
>>>
>>> https://patchwork.kernel.org/patch/10766673/
>>>
>>> Trying to figure out what to do now.
>>
>> This is commit aecc787c06f4300f ("iomap: Use non-raw io functions for
>> io{read|write}XXbe"):
>>
>> --- a/lib/iomap.c
>> +++ b/lib/iomap.c
>> @@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const
>> char *access)
>>   #endif
>>
>>   #ifndef mmio_read16be
>> -#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
>> -#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
>> +#define mmio_read16be(addr) swab16(readw(addr))
>> +#define mmio_read32be(addr) swab32(readl(addr))
>>   #endif
>>
>>   unsigned int ioread8(void __iomem *addr)
>> @@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
>>   #endif
>>
>>   #ifndef mmio_write16be
>> -#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
>> -#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
>> +#define mmio_write16be(val,port) writew(swab16(val),port)
>> +#define mmio_write32be(val,port) writel(swab32(val),port)
>>
>> On big endian, the raw accessors are assumed to be non-swapping,
>> while non-raw accessors are assumed to be swapping.
>> The latter is not true for Coldfire internal registers, cfr.
>> arch/m68k/include/asm/io_no.h:
> 
> The raw accessors are always assumed to be non-swapping
> in the asm-generic code, while the non-raw ones are assumed to
> be little-endian in order for them to work with portable drivers.
> 
> We have some other cases of big-endian machines that use
> a hardware byteswap on their MMIO buses (iirc some mips
> and superh parts), but they then need to swap the __raw_*
> accessor data words in software to get back to the normal
> behavior, as well as swizzle the address for accesses that are
> less than 32 bit wide.
> 
> Coldfire makes the behavior of readw()/readl() depend on the
> MMIO address, presumably since that was the easiest way to
> get drivers working originally, but it breaks the assumption
> in the asm-generic code.

Yes, that is right.

There is a number of common hardware modules that Freescale have
used in the ColdFire SoC parts and in their ARM based parts (iMX
families). The ARM parts are pretty much always little endian, and
the ColdFire is always big endian. The hardware registers in those
hardware blocks are always accessed in native endian of the processor.

So the address range checks are to deal with those internal
hardware blocks (i2c, spi, dma, etc), since we know those are
at fixed addresses. That leaves the usual endian swapping in place for
other general (ie external) devices (PCI devices, network chips, etc).


>> static inline u16 readw(const volatile void __iomem *addr)
>> {
>>          if (cf_internalio(addr))
>>                  return __raw_readw(addr);
>>          return __le16_to_cpu(__raw_readw(addr));
>> }
>>
>> Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
>> questionable to swap data twice on big endian architectures.
> 
> I would expect that the compiler is capable of detecting a double
> swap and optimize it out. Even if it can't, there are not that many
> instances of io{read,write}{16,32}be in the kernel, so the increase
> in kernel image size from a double swap should be limited to a
> few extra instructions, and the runtime overhead should be
> negligible compared to the bus access.
> 
>> Fortunately we can avoid that by defining our own
>> mmio_{read,write}{16,32}be()...

Makes sense.

Regards
Greg


