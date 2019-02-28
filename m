Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C858C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1420842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfB1Gkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:40:32 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:35191 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730862AbfB1Gkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:40:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=SPAM|CONTINUE|true|0.671701-0.116697-0.211603;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.E2LjoQK_1551336024;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E2LjoQK_1551336024)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 28 Feb 2019 14:40:24 +0800
Subject: Re: [RFC v9 5/5] Documentation: pstore/blk: create document for
 pstore_blk
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1550577170-18761-6-git-send-email-liaoweixiong@allwinnertech.com>
 <8cae4c38-d7e6-67e6-b855-4454c59f60bd@infradead.org>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <7eb8e9c8-ccd5-6ce0-3e03-fe158389d446@allwinnertech.com>
Date:   Thu, 28 Feb 2019 14:40:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8cae4c38-d7e6-67e6-b855-4454c59f60bd@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your correction. I will update the patch in the 12th version.

On 2019/02/28 13:15, Randy Dunlap wrote:
> On 2/19/19 3:52 AM, liaoweixiong wrote:
>> The document, at Documentation/admin-guide/pstore-block.rst,
>> tells user how to use pstore_blk and the attentions about panic
>> read/write
>>
>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
>> ---
>>  Documentation/admin-guide/pstore-block.rst | 233 +++++++++++++++++++++++++++++
>>  MAINTAINERS                                |   1 +
>>  fs/pstore/Kconfig                          |   4 +
>>  3 files changed, 238 insertions(+)
>>  create mode 100644 Documentation/admin-guide/pstore-block.rst
>>
>> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
>> new file mode 100644
>> index 0000000..a828274
>> --- /dev/null
>> +++ b/Documentation/admin-guide/pstore-block.rst
>> @@ -0,0 +1,233 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Pstore block oops/panic logger
>> +==============================
>> +
>> +Introduction
>> +------------
>> +
>> +Pstore block (pstore_blk) is an oops/panic logger that write its logs to block
> 
>                                                                          to a block
> 
>> +device before the system crashes. Pstore_blk needs block device driver
> 
>                                                 needs the block
> 
>> +registering a partition path of the block device, like /dev/mmcblk0p7 for mmc
> 
>    to register                                                           for MMC
> 
>> +driver, and read/write APIs for this partition when on panic.
>> +
>> +Pstore block concepts
>> +---------------------
>> +
>> +Pstore block begins at function ``blkz_register``, by which block driver
> 
>                                                       by which a block driver
> 
>> +registers to pstore_blk. Note that, block driver should register to pstore_blk
> 
>                             Note that the block driver should
> 
>> +after block device has registered. Block driver transfers a structure
> 
>                                       The block driver
> 
>> +``blkz_info`` which is defined in *linux/pstore_blk.h*.
>> +
>> +The following key members of ``struct blkz_info`` may be of interest to you.
>> +
>> +blkdev
>> +~~~~~~
>> +
>> +The block device to use. Most of the time, it is a partition of block device.
>> +It's ok to keep it as NULL if you passing ``read`` and ``write`` in blkz_info as
> 
>                               if you are passing
> 
>> +``blkdev`` is used by blkz_default_general_read/write. If both of ``blkdev``,
>> +``read`` and ``write`` are NULL, no block device is effective and the data will
>> +be saved in ddr buffer.
> 
> what is ddr buffer?
> 

It is a buffer allocated from RAM. I modify it as follow:
If both of ``blkdev``, ``read`` and ``write`` are NULL, no block device
is effective and the data will only be saved in RAM.

>> +
>> +It accept the following variants:
>> +
>> +1. <hex_major><hex_minor> device number in hexadecimal represents itself no
> 
>                                                                      itself; no
> 
>> +   leading 0x, for example b302.
>> +#. /dev/<disk_name> represents the device number of disk
>> +#. /dev/<disk_name><decimal> represents the device number of partition - device
>> +   number of disk plus the partition number
>> +#. /dev/<disk_name>p<decimal> - same as the above, that form is used when disk
> 
>                                                above; this form
> 
>> +   name of partitioned disk ends on a digit.
> 
>                                ends with a digit.
> 
>> +#. PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the unique id of
>> +   a partition if the partition table provides it. The UUID may be either an
>> +   EFI/GPT UUID, or refer to an MSDOS partition using the format SSSSSSSS-PP,
>> +   where SSSSSSSS is a zero-filled hex representation of the 32-bit
>> +   "NT disk signature", and PP is a zero-filled hex representation of the
>> +   1-based partition number.
>> +#. PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to a
>> +   partition with a known unique id.
>> +#. <major>:<minor> major and minor number of the device separated by a colon.
>> +
>> +See more on section **read/write**.
> 
>             in section
> 
>> +
>> +total_size
>> +~~~~~~~~~~
>> +
>> +The total size in bytes of block device used for pstore_blk. It **MUST** be less
>> +than or equal to size of block device if ``blkdev`` valid. It **MUST** be a
>> +multiple of 4096. If ``total_size`` is zero with ``blkdev``, ``total_size`` will be
>> +set to equal to size of ``blkdev``.
>> +
>> +The block device area is divided into many chunks, and each event writes a chunk
>> +of information.
>> +
>> +dmesg_size
>> +~~~~~~~~~~
>> +
>> +The chunk size in bytes for dmesg(oops/panic). It **MUST** be a multiple of
>> +SECTOR_SIZE (Most of the time, the SECTOR_SIZE is 512). If you don't need dmesg,
>> +you are safely to set it to 0.
> 
>    you can safely
> 
>> +
>> +NOTE that, the remaining space, except ``pmsg_size`` and others, belongs to
>> +dmesg. It means that there are multiple chunks for dmesg.
>> +
>> +Psotre_blk will log to dmesg chunks one by one, and always overwrite the oldest
> 
>    Pstore_blk
> 
>> +chunk if no free chunk.
>> +
>> +pmsg_size
>> +~~~~~~~~~
>> +
>> +The chunk size in bytes for pmsg. It **MUST** be a multiple of SECTOR_SIZE (Most
>> +of the time, the SECTOR_SIZE is 512). If you don't need pmsg, you are safely to
> 
>                                                                  you can safely {drop "to"}
> 
>> +set it to 0.
>> +
>> +There is only one chunk for pmsg.
>> +
>> +Pmsg is a user space accessible pstore object. Writes to */dev/pmsg0* are
>> +appended to the chunk. On reboot the contents are available in
>> +/sys/fs/pstore/pmsg-pstore-blk-0.
>> +
>> +dump_oops
>> +~~~~~~~~~
>> +
>> +Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
>> +member while setting 0 in that variable dumps only the panics.
>> +
>> +read/write
>> +~~~~~~~~~~
>> +
>> +They are general ``read/write`` APIs. It is safely and recommended to ignore it,
> 
>                                          It is safe and recommended
> 
>> +but set ``blkdev``.
>> +
>> +These general APIs are used all the time expect panic. The ``read`` API is
>> +usually used to recover data from block device, and the ``write`` API is usually
>> +to flush new data and erase to block device.
>> +
>> +Pstore_blk will temporarily hold all new data before block device is ready. If
>> +you ignore both of ``read/write`` and ``blkdev``, the old data will be lost.
>> +
>> +NOTE that, the general APIs must check whether the block device is ready if
> 
>    NOTE that the general
> 
>> +self-defined.
>> +
>> +panic_read/panic_write
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +They are ``read/write`` APIs for panic. They are likely to general
> 
>                                            They are like the general
> 
> 
>> +``read/write`` but will be used only when on panic.
>> +
>> +The attentions for panic read/write see section
>> +**Attentions in panic read/write APIs**.
>> +
>> +Register to pstore block
>> +------------------------
>> +
>> +Block device driver call ``blkz_register`` to register to Psotre_blk.
> 
>                                                              Pstore_blk.
> 
>> +For example:
>> +
>> +.. code-block:: c
>> +
>> + #include <linux/pstore_blk.h>
>> + [...]
>> +
>> + static ssize_t XXXX_panic_read(char *buf, size bytes, loff_t pos)
>> + {
>> +    [...]
>> + }
>> +
>> + static ssize_t XXXX_panic_write(const char *buf, size_t bytes, loff_t pos)
>> + {
>> +        [...]
>> + }
>> +
>> + struct blkz_info XXXX_info = {
>> +        .onwer = THIS_MODULE,
>> +        .name = <...>,
>> +        .dmesg_size = <...>,
>> +        .pmsg_size = <...>,
>> +        .dump_oops = true,
>> +        .panic_read = XXXX_panic_read,
>> +        .panic_write = XXXX_panic_write,
>> + };
>> +
>> + static int __init XXXX_init(void)
>> + {
>> +        [... get block device information ...]
>> +        XXXX_info.blkdev = <...>;
>> +        XXXX_info.total_size = <...>;
>> +
>> +        [...]
>> +        return blkz_register(&XXXX_info);
>> + }
>> +
>> +There are multiple ways by which you can get block device information.
>> +
>> +A. Use the module parameters and kernel cmdline.
>> +B. Use Device Tree bindings.
>> +C. Use Kconfig.
>> +D. Use Driver Feature.
>> +   For example, traverse all MTD device by ``register_mtd_user``, and get the
> 
>                                     devices
> 
>> +   matching name MTD partition.
>> +
>> +NOTE that, all of above are done by block driver rather then pstore_blk. You can
> 
>    NOTE that all of the above are done by the block driver
> 
>> +get sample on blkoops.
>> +
>> +The attentions for panic read/write see section
>> +**Attentions in panic read/write APIs**.
>> +
>> +Compression and header
>> +----------------------
>> +
>> +Block device is large enough, it is not necessary to compress dmesg data.
>> +Actually, we recommend not compress. Because pstore_blk will insert some
> 
>                               compressing because
> 
>> +information into the first line of dmesg data if no compression.
>> +For example::
>> +
>> +        Panic: Total 16 times
>> +
>> +It means that it's the 16th times panic log since burning.
> 
> what is "burning"?
> 

It is something about embedded device installing system. It was my
negligence not to consider the compatibility of concepts. I modify it as
follow:
It means that it's the 16th times panic log since the first  booting.

>> +Sometimes, the oops|panic counter since burning is very important for embedded
>> +device to judge whether the system is stable.
>> +
>> +The follow line is insert by pstore filesystem.
> 
>        following line is inserted
> 
>> +For example::
>> +
>> +        Oops#2 Part1
>> +
>> +It means that it's the 2nd times oops log on last booting.
>> +
>> +Reading the data
>> +----------------
>> +
>> +The dump data can be read from the pstore filesystem. The format for these
>> +files is ``dmesg-pstore-blk-[N]`` for dmesg(oops|panic) and
>> +``pmsg-pstore-blk-0`` for pmsg, where N is the record number. To delete a stored
>> +record from block device, simply unlink the respective pstore file. The
>> +timestamp of the dump file records the trigger time.
>> +
>> +Attentions in panic read/write APIs
>> +-----------------------------------
>> +
>> +If on panic, the kernel is not going to be running for much longer. The tasks
>> +will not be scheduled and the most kernel resources will be out of service. It
>> +looks like a single-threaded program running on a single-core computer.
>> +
>> +The following points need special attention for panic read/write APIs:
>> +
>> +1. Can **NOT** allocate any memory.
>> +   If you need memory, just allocate while the block driver is initialing rather
> 
>                                                                   initializing
> 
>> +   than waiting until the panic.
>> +#. Must be polled, **NOT** interrupt driven.
>> +   No task schedule any more. The block driver should delay to ensure the write
>> +   succeeds, but NOT sleep.
>> +#. Can **NOT** take any lock.
>> +   There is no other task, no any share resource, you are safely to break all
> 
>                               nor any shared resource; you are safe to break all
> 
>> +   locks.
>> +#. Just use cpu to transfer.
> 
>                CPU
> 
>> +   Do not use DMA to transfer unless you are sure that DMA will not keep lock.
>> +#. Operate register directly.
>> +   Try not to use linux kernel resources. Do io map while initialing rather than
> 
>                      Linux                      I/O          initializing
> 
>> +   waiting until the panic.
>> +#. Reset your block device and controller if necessary.
>> +   If you are not sure the state of you block device and controller when panic,
>> +   you are safely to stop and reset them.
> 
>       you are safe to
> 
> 
> 
> cheers.
> 

-- 
liaoweixiong
