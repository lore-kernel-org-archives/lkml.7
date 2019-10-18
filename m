Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D75CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B493820679
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393203AbfJRWQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:16:56 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:45020 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387573AbfJRWQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:16:54 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1iLaYD-00039g-0d; Sat, 19 Oct 2019 00:16:49 +0200
Subject: Re: [PATCH] zswap: allow setting default status, compressor and
 allocator in Kconfig
To:     Dan Streetman <ddstreet@ieee.org>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitalywool@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191011234038.198995-1-mail@maciej.szmigiero.name>
 <CALZtONCx4L5K7+h3TuS1Ms_q_Mt_5JcZ+XTgACqdDyVsaCS76g@mail.gmail.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 PA==
Message-ID: <d7e1c0ca-80e9-233a-c4ea-d7fccaf56722@maciej.szmigiero.name>
Date:   Sat, 19 Oct 2019 00:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALZtONCx4L5K7+h3TuS1Ms_q_Mt_5JcZ+XTgACqdDyVsaCS76g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2019 13:19, Dan Streetman wrote:
> On Fri, Oct 11, 2019 at 7:40 PM Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>>
>> The compressed cache for swap pages (zswap) currently needs from 1 to 3
>> extra kernel command line parameters in order to make it work: it has to be
>> enabled by adding a "zswap.enabled=1" command line parameter and if one
>> wants a different compressor or pool allocator than the default lzo / zbud
>> combination then these choices also need to be specified on the kernel
>> command line in additional parameters.
>>
>> Using a different compressor and allocator for zswap is actually pretty
>> common as guides often recommend using the lz4 / z3fold pair instead of
>> the default one.
>> In such case it is also necessary to remember to enable the appropriate
>> compression algorithm and pool allocator in the kernel config manually.
>>
>> Let's avoid the need for adding these kernel command line parameters and
>> automatically pull in the dependencies for the selected compressor
>> algorithm and pool allocator by adding an appropriate default switches to
>> Kconfig.
> 
> Who is the target for using these kernel build-time defaults?  I don't
> think any distribution would be defaulting zswap to enabled, and if
> the config defaults are intended for personal kernel builds, it is
> really so much harder to just configure it on the boot cmdline?

Appropriate kernel config defaults are normally provided for kernel
parameters that are reasonably expected to be configured for normal
operation (and sometimes for debugging parameters, too), so one does not
need to boot kernel with a lot of command line parameters to get the
desired behavior.

A quick, limited grep of Documentation/admin-guide/kernel-parameters.txt
gives me the following config options that control the default values of
command line parameters:
CONFIG_HPET_MMAP_DEFAULT
CONFIG_BOOTPARAM_HUNG_TASK_PANIC
CONFIG_INIT_ON_ALLOC_DEFAULT_ON
CONFIG_INIT_ON_FREE_DEFAULT_ON
CONFIG_IOMMU_DEFAULT_PASSTHROUGH
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF
CONFIG_LSM
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
CONFIG_RANDOM_TRUST_CPU
CONFIG_SLUB_MEMCG_SYSFS_ON
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC
CONFIG_SYSFS_DEPRECATED_V2
CONFIG_COMPAT_VDSO
CONFIG_WQ_POWER_EFFICIENT_DEFAULT
CONFIG_XEN_SCRUB_PAGES_DEFAULT

There are countless other ones that set the default values for module
parameters, for example in the "sound" directory alone there are four:
CONFIG_SND_PS3_DEFAULT_START_DELAY
CONFIG_SND_HDA_POWER_SAVE_DEFAULT
CONFIG_SND_AC97_POWER_SAVE_DEFAULT
CONFIG_SND_SEQ_HRTIMER_DEFAULT

Providing such selectable default also means that the dependencies for
the selected compressor algorithm and pool allocator are pulled in
automatically - the old way pulled in the LZO algorithm (and only the
LZO algorithm) into the kernel unconditionally, even if the user was
ultimately going to use another algorithm.

>>
>> The default values for these options match what the code was using
>> previously as its defaults.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>  mm/Kconfig | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  mm/zswap.c |  26 ++++++++------
>>  2 files changed, 117 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index a5dae9a7eb51..4309bcaaa29d 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -525,7 +525,6 @@ config MEM_SOFT_DIRTY
>>  config ZSWAP
>>         bool "Compressed cache for swap pages (EXPERIMENTAL)"
>>         depends on FRONTSWAP && CRYPTO=y
>> -       select CRYPTO_LZO
>>         select ZPOOL
>>         help
>>           A lightweight compressed cache for swap pages.  It takes
>> @@ -541,6 +540,108 @@ config ZSWAP
>>           they have not be fully explored on the large set of potential
>>           configurations and workloads that exist.
>>
>> +choice
> 
> Using choice becomes a bit of a maintenence issue...if we add this,
> wouldn't it be better to use string input so new compression algs can
> be added without having to update this Kconfig?

If this is changed to a string prompt we'll lose automatic pulling in of
an appropriate CONFIG_CRYPTO_* dependency.

Other similar options are presented as a choice, too, see for example
CONFIG_KERNEL_{GZIP,BZIP2,LZMA,XZ,LZO,LZ4,UNCOMPRESSED} and
CONFIG_INITRAMFS_COMPRESSION_{NONE,GZIP,BZIP2,LZMA,XZ,LZO,LZ4} (that
maps to an extension string table called CONFIG_INITRAMFS_COMPRESSION).

BTW: New compression algorithm being added to the kernel is a rare
event, I also envision that not every new algorithm will need to be
presented as a choice for zswap default.

>> +       prompt "Compressed cache for swap pages default compressor"
>> +       depends on ZSWAP
>> +       default ZSWAP_DEFAULT_COMP_LZO
>> +       help
>> +         Selects the default compression algorithm for the compressed cache
>> +         for swap pages.
>> +         If in doubt, select 'LZO'.
>> +
>> +         The selection made here can be overridden by using the kernel
>> +         command line 'zswap.compressor=' option.
>> +
>> +config ZSWAP_DEFAULT_COMP_DEFLATE
>> +       bool "Deflate"
>> +       select CRYPTO_DEFLATE
>> +       help
>> +         Use the Deflate algorithm as the default compression algorithm.
>> +
>> +config ZSWAP_DEFAULT_COMP_LZO
>> +       bool "LZO"
>> +       select CRYPTO_LZO
>> +       help
>> +         Use the LZO algorithm as the default compression algorithm.
>> +
>> +config ZSWAP_DEFAULT_COMP_842
>> +       bool "842"
>> +       select CRYPTO_842
>> +       help
>> +         Use the 842 algorithm as the default compression algorithm.
>> +
>> +config ZSWAP_DEFAULT_COMP_LZ4
>> +       bool "LZ4"
>> +       select CRYPTO_LZ4
>> +       help
>> +         Use the LZ4 algorithm as the default compression algorithm.
>> +
>> +config ZSWAP_DEFAULT_COMP_LZ4HC
>> +       bool "LZ4HC"
>> +       select CRYPTO_LZ4HC
>> +       help
>> +         Use the LZ4HC algorithm as the default compression algorithm.
>> +
>> +config ZSWAP_DEFAULT_COMP_ZSTD
>> +       bool "zstd"
>> +       select CRYPTO_ZSTD
>> +       help
>> +         Use the zstd algorithm as the default compression algorithm.
>> +endchoice
>> +
>> +config ZSWAP_DEFAULT_COMP_NAME
>> +       string
>> +       default "deflate" if ZSWAP_DEFAULT_COMP_DEFLATE
>> +       default "lzo" if ZSWAP_DEFAULT_COMP_LZO
>> +       default "842" if ZSWAP_DEFAULT_COMP_842
>> +       default "lz4" if ZSWAP_DEFAULT_COMP_LZ4
>> +       default "lz4hc" if ZSWAP_DEFAULT_COMP_LZ4HC
>> +       default "zstd" if ZSWAP_DEFAULT_COMP_ZSTD
>> +       default ""
>> +
>> +choice
>> +       prompt "Compressed cache for swap pages default allocator"
>> +       depends on ZSWAP
>> +       default ZSWAP_DEFAULT_ZPOOL_ZBUD
>> +       help
>> +         Selects the default allocator for the compressed cache for
>> +         swap pages.
>> +         The default is 'zbud' for compatibility, however please do
>> +         read the description of each of the allocators below before
>> +         making a right choice.
>> +
>> +         The selection made here can be overridden by using the kernel
>> +         command line 'zswap.zpool=' option.
>> +
>> +config ZSWAP_DEFAULT_ZPOOL_ZBUD
>> +       bool "zbud"
>> +       select ZBUD
>> +       help
>> +         Use the zbud allocator as the default allocator.
>> +
>> +config ZSWAP_DEFAULT_ZPOOL_Z3FOLD
>> +       bool "z3fold"
>> +       select Z3FOLD
>> +       help
>> +         Use the z3fold allocator as the default allocator.
>> +endchoice
>> +
>> +config ZSWAP_DEFAULT_ZPOOL_NAME
>> +       string
>> +       default "zbud" if ZSWAP_DEFAULT_ZPOOL_ZBUD
>> +       default "z3fold" if ZSWAP_DEFAULT_ZPOOL_Z3FOLD
>> +       default ""
>> +
>> +config ZSWAP_DEFAULT_ON
>> +       bool "Enable the compressed cache for swap pages by default"
>> +       depends on ZSWAP
>> +       help
>> +         If selected, the compressed cache for swap pages will be enabled
>> +         at boot, otherwise it will be disabled.
>> +
>> +         The selection made here can be overridden by using the kernel
>> +         command line 'zswap.enabled=' option.
>> +
>>  config ZPOOL
>>         tristate "Common API for compressed memory storage"
>>         help
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 46a322316e52..59231f6fb2ca 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -71,8 +71,12 @@ static u64 zswap_duplicate_entry;
>>
>>  #define ZSWAP_PARAM_UNSET ""
>>
>> -/* Enable/disable zswap (disabled by default) */
>> +/* Enable/disable zswap */
>> +#ifdef CONFIG_ZSWAP_DEFAULT_ON
>> +static bool zswap_enabled = true;
>> +#else
>>  static bool zswap_enabled;
>> +#endif
>>  static int zswap_enabled_param_set(const char *,
>>                                    const struct kernel_param *);
>>  static struct kernel_param_ops zswap_enabled_param_ops = {
>> @@ -82,8 +86,7 @@ static struct kernel_param_ops zswap_enabled_param_ops = {
>>  module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
>>
>>  /* Crypto compressor to use */
>> -#define ZSWAP_COMPRESSOR_DEFAULT "lzo"
>> -static char *zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
>> +static char *zswap_compressor = CONFIG_ZSWAP_DEFAULT_COMP_NAME;
>>  static int zswap_compressor_param_set(const char *,
>>                                       const struct kernel_param *);
>>  static struct kernel_param_ops zswap_compressor_param_ops = {
>> @@ -95,8 +98,7 @@ module_param_cb(compressor, &zswap_compressor_param_ops,
>>                 &zswap_compressor, 0644);
>>
>>  /* Compressed storage zpool to use */
>> -#define ZSWAP_ZPOOL_DEFAULT "zbud"
>> -static char *zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
>> +static char *zswap_zpool_type = CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME;
>>  static int zswap_zpool_param_set(const char *, const struct kernel_param *);
>>  static struct kernel_param_ops zswap_zpool_param_ops = {
>>         .set =          zswap_zpool_param_set,
>> @@ -569,11 +571,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
>>         bool has_comp, has_zpool;
>>
>>         has_comp = crypto_has_comp(zswap_compressor, 0, 0);
>> -       if (!has_comp && strcmp(zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT)) {
>> +       if (!has_comp && strcmp(zswap_compressor,
>> +                               CONFIG_ZSWAP_DEFAULT_COMP_NAME)) {
> 
> bit of bikeshedding, wouldn't CONFIG_ZSWAP_COMPRESSOR_DEFAULT be
> clearer than CONFIG_ZSWAP_DEFAULT_COMP_NAME?

I'm fine either way (used "COMP" instead of "COMPRESSOR" to shorten these
identifiers a bit), also CONFIG_ZSWAP_DEFAULT_ZPOOL_NAME then probably
would need renaming to CONFIG_ZSWAP_ZPOOL_DEFAULT for consistency.

Thanks,
Maciej
