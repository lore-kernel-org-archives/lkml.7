Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DBFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F18C2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLPCeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:34:04 -0500
Received: from regular1.263xmail.com ([211.150.70.205]:36250 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPCeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:34:04 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 21:34:02 EST
Received: from localhost (unknown [192.168.167.8])
        by regular1.263xmail.com (Postfix) with ESMTP id D931830B;
        Mon, 16 Dec 2019 10:27:27 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.30.14] (42.17.110.36.static.bjtelecom.net [36.110.17.42])
        by smtp.263.net (postfix) whith ESMTP id P17319T140438588901120S1576463244936062_;
        Mon, 16 Dec 2019 10:27:28 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <342511b45ad3cafeca5a7222a80a4930>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: lvlisong@emindsoft.com.cn
X-SENDER-IP: 36.110.17.42
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
Subject: Re: [PATCH] drivers: tty: serial: 8250: fintek: Can enable or disable
 irq sharing based on isa or pci bus
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, sr@denx.de,
        mika.westerberg@linux.intel.com, yegorslists@googlemail.com,
        yuehaibing@huawei.com, haolee.swjtu@gmail.com, dsterba@suse.com,
        mojha@codeaurora.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lv Li-song <lvlisong@emindsoft.com.cn>
References: <20191213051717.2058-1-chengang@emindsoft.com.cn>
 <20191213105033.GT32742@smile.fi.intel.com>
From:   Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <758a0ca9-8f81-1a10-d9e1-11f86fac3de1@emindsoft.com.cn>
Date:   Mon, 16 Dec 2019 10:27:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191213105033.GT32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

I guess, this patch has to be refactored to match the related linux
versions. And excuse me, my orignal hardware environments has been gone,
so I can not give the new refactored patch additional test.

It is necessary to continue discussing and reviewing this patch to let
it be known completely, but I guess I am not the suitable persion to
refactor the patch.

After finish discussing and reviewing, if anyone still wants me to
refactor the patch, please let me know, I shall try.

The contents below are my reply, pelease check, thanks.

On 2019/12/13 下午6:50, Andy Shevchenko wrote:
> On Fri, Dec 13, 2019 at 01:17:17PM +0800, chengang@emindsoft.com.cn wrote:
>> From: Chen Gang <chengang@emindsoft.com.cn>
>> Sorry for this patch being too late, which is for linux-next 20151127 (
>> about linux 4.4-rc2).  After 4 years, much things have been changed. But
>> I think it might be still valuable for some old versions. Welcome anyone
>> to refact this patch for their own.
> 
> This part should go after '---' line below.
> 
>> Fintek serial ports can share irq, but they need be enabled firstly, so
>> enable or disable irq sharing based on isa or pci bus. From kconfig, it
> 
> irq -> IRQ
> isa -> ISA
> pci -> PCI
> kconfig -> Kconfig
> 
>> can be configured.
>>
>> For integrated 8250 drivers, kernel always calls pnp driver, which will
>> not use integrated fintek driver for ever. So let pnp driver try the
> 
> fintek -> Fintek or Fintek 8250
> 
>> other drivers firstly (e.g. fintek), if fail, try pnp driver its own.
> 
> Ditto.
> 

OK, thanks.

> 
>> --- a/drivers/tty/serial/8250/8250.h
>> +++ b/drivers/tty/serial/8250/8250.h
>> @@ -14,6 +14,7 @@
>>  #include <linux/serial_8250.h>
>>  #include <linux/serial_reg.h>
>>  #include <linux/dmaengine.h>
> 
>> +#include <linux/pnp.h>
> 
> The changes below doesn't require a header.
> Pointers are known to the compiler. Names of data structures can be forward
> declared. Moreover, these declarations may go inside respective #ifdef.
> 

OK. I guess, originally, I forgot to remove it.

> 
>> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
>> +
>> +static void set_icsr(u16 base_port, u8 index)
>> +{
>> +	uint8_t icsr = 0;
>> +
>> +	outb(LDN, base_port + ADDR_PORT);
>> +	outb(index, base_port + DATA_PORT);
>> +	outb(ICSR, base_port + ADDR_PORT);
>> +	icsr = inb(base_port + DATA_PORT);
>> +
>> +	if (icsr != 0xff) {
> 
> 	if (icsr == 0xff)
> 		return;
> 

It'll be OK.

> 
>> +		icsr |= IRQ_SHARING_MOD;
>> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING_ISA)
>> +		icsr |= ISA_IRQ_SHARING;
>> +#else
>> +		icsr |= PCI_IRQ_SHARING;
>> +#endif
>> +		outb(ICSR, base_port + ADDR_PORT);
>> +		outb(icsr, base_port + DATA_PORT);
>> +	}
>> +}
>> +
>> +#endif
> 
> ..
> 
>>  				aux |= inb(addr[i] + DATA_PORT) << 8;
>>  				if (aux != io_address)
>>  					continue;
> 
>> -
> 
> What the point?
> 
>> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
>> +				set_icsr(addr[i], k);
>> +#endif
>>  				fintek_8250_exit_key(addr[i]);
>>  				*key = keys[j];
>>  				*index = k;
>> @@ -179,53 +212,6 @@ static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
>>  	return -ENODEV;
>>  }
>>  

In my case at that time, for fintex irq sharing, it needed additional
initinalization, or it could not work well. I wrote the related code
based on the fintek data-sheet which was downloaded from internet.

>> -static int
>> -fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
> 
> Why did you move this function?
> It's now not only hard to follow what has been changed, and to review.
> 
>> --- a/drivers/tty/serial/8250/8250_pnp.c
>> +++ b/drivers/tty/serial/8250/8250_pnp.c
>> @@ -438,8 +438,13 @@ static int
>>  serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>>  {
>>  	struct uart_8250_port uart, *port;
>> -	int ret, line, flags = dev_id->driver_data;
>> +	int ret, line, flags;
>>  
> 

I thought locating the main probe function at the end of the source file
was better for normal code reading (maybe it need be a seperate patch).
But if we don't mind, we can still remain its orignal position.

>> +#if IS_BUILTIN(CONFIG_SERIAL_8250_FINTEK)
>> +	if (!fintek_8250_probe(dev, dev_id))
>> +		return 0;
>> +#endif
>> +	flags = dev_id->driver_data;
> 
> Oh, I don't like this.
> It needs a bit more refactoring done first.
> 
> The idea that we are not going to pollute generic driver(s) with quirks anymore
> (only when it's really unavoidable).
> 

At that time, for me, I could not get any new better ways in a short
time, and the issue had to be fixed in time, so the code was not good
engough.

At present, Linux version has been changed much, welcome any one to
refactor it for current linux version or another related old linux
versions if this patch is valuable more or less.


Thanks.


