Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D22DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E49021783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SnQ75Xlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfJVHli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:41:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41532 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfJVHlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:41:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9M7fVUw036646;
        Tue, 22 Oct 2019 02:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571730091;
        bh=dPQn7RB6hDO3IIkmAS8X4BbmzOamOYh7gFgkBWFmPZE=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=SnQ75XlkwUOrZWKyo0e5mXbzNDqp8DVSznfg4OLTTUyFBVC1aJ/dupJFnw5yo8ORS
         V3HXVV0hWYT2V126NRu1PgwVhZLtViL61XHek5lhhwGiF2Y9v9HZZTInmalvFf42GW
         VE/uw4zCjMi73wOcjHlJIiiQjt/EdB37y1a53jtI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9M7fVx4008315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 02:41:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 02:41:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 02:41:21 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9M7fSw7097598;
        Tue, 22 Oct 2019 02:41:29 -0500
Subject: Re: [PATCH] ARM: davinci: dm365-evm: Add Fixed regulators needed for
 tlv320aic3101
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, <bgolaszewski@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190830102252.22488-1-peter.ujfalusi@ti.com>
 <e2e10e39-aa21-1c53-75b2-18013937a841@ti.com>
 <698562e3-6391-f0e3-a7a8-f64794cfa33e@ti.com>
 <7a6179ab-6ef1-767d-9b19-576aa1c6dcdd@ti.com>
Message-ID: <14d31170-82ab-f263-e23d-14835e968ce3@ti.com>
Date:   Tue, 22 Oct 2019 10:42:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7a6179ab-6ef1-767d-9b19-576aa1c6dcdd@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/10/2019 13.40, Peter Ujfalusi wrote:
> 
> 
> On 17/10/2019 16.49, Sekhar Nori wrote:
>> On 17/10/19 4:39 PM, Sekhar Nori wrote:
>>> On 30/08/19 3:52 PM, Peter Ujfalusi wrote:
>>>> The codec driver needs correct regulators in order to probe.
>>>> Both VCC_3V3 and VCC_1V8 is always on fixed regulators on the board.
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>
>>> Applied for v5.4
>>
>> This is breaking boot on DM365 EVM.
>>
>> Booting Linux on physical CPU 0x0                                               
>> Linux version 5.4.0-rc1-00001-g927d10a85791-dirty (a0875516@psplinux063) (gcc v9
>> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f                   
>> CPU: VIVT data cache, VIVT instruction cache                                    
>> Machine: DaVinci DM365 EVM                                                      
>> Memory policy: Data cache writethrough                                          
>> cma: Reserved 16 MiB at 0x86c00000                                              
>> DaVinci dm365_rev1.1 variant 0x0                                                
>> On node 0 totalpages: 32768                                                     
>>   DMA zone: 256 pages used for memmap                                           
>>   DMA zone: 0 pages reserved                                                    
>>   DMA zone: 32768 pages, LIFO batch:7                                           
>> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768                                   
>> pcpu-alloc: [0] 0                                                               
>> Built 1 zonelists, mobility grouping on.  Total pages: 32512                    
>> Kernel command line: console=ttyS0,115200n8 root=/dev/nfs rw nfsroot=172.24.210p
>> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)          
>> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)            
>> mem auto-init: stack:off, heap alloc:off, heap free:off                         
>> Memory: 106776K/131072K available (4760K kernel code, 253K rwdata, 1160K rodata)
>> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1                      
>> rcu: Preemptible hierarchical RCU implementation.                               
>>         Tasks RCU enabled.                                                      
>> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.          
>> NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16                                 
>> random: get_random_bytes called from start_kernel+0x25c/0x440 with crng_init=0  
>> clocksource: timer0_1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79s
>> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns       
>> Console: colour dummy device 80x30                                              
>> Calibrating delay loop... 146.84 BogoMIPS (lpj=734208)                          
>> pid_max: default: 32768 minimum: 301                                            
>> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)             
>> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)        
>> CPU: Testing write buffer coherency: ok                                         
>> Setting up static identity map for 0x80008400 - 0x80008458                      
>> rcu: Hierarchical SRCU implementation.                                          
>> devtmpfs: initialized                                                           
>> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 191s
>> futex hash table entries: 256 (order: -1, 3072 bytes, linear)                   
>> pinctrl core: initialized pinctrl subsystem                                     
>> NET: Registered protocol family 16                                              
>> DMA: preallocated 256 KiB pool for atomic coherent allocations                  
>> mux: initialized INT_EDMA_CC                                                    
>> mux: Setting register INT_EDMA_CC                                               
>> mux:    INTMUX (0x00000018) = 0x00000000 -> 0x00000004                          
>> cpuidle: using governor menu                                                    
>> mux: initialized INT_EMAC_RXTHRESH                                              
>> mux: Setting register INT_EMAC_RXTHRESH                                         
>> mux:    INTMUX (0x00000018) = 0x00000004 -> 0x00004004                          
>> mux: initialized INT_EMAC_RXPULSE                                               
>> mux: Setting register INT_EMAC_RXPULSE                                          
>> mux:    INTMUX (0x00000018) = 0x00004004 -> 0x0000c004                          
>> mux: initialized INT_EMAC_TXPULSE                                               
>> mux: Setting register INT_EMAC_TXPULSE                                          
>> mux:    INTMUX (0x00000018) = 0x0000c004 -> 0x0001c004                          
>> mux: initialized INT_EMAC_MISCPULSE                                             
>> mux: Setting register INT_EMAC_MISCPULSE                                        
>> mux:    INTMUX (0x00000018) = 0x0001c004 -> 0x0003c004                          
>> EVM: tvp5146 SD video input                                                     
>> mux: initialized INT_PRTCSS                                                     
>> mux: Setting register INT_PRTCSS                                                
>> mux:    INTMUX (0x00000018) = 0x0003c004 -> 0x0003c404                          
>> mux: initialized SPI0_SCLK                                                      
>> mux: Setting register SPI0_SCLK                                                 
>> mux:    PINMUX3 (0x0000000c) = 0x015affff -> 0x115affff                         
>> mux: initialized SPI0_SDI                                                       
>> mux: Setting register SPI0_SDI                                                  
>> mux:    PINMUX3 (0x0000000c) = 0x115affff -> 0x155affff                         
>> mux: initialized SPI0_SDO                                                       
>> mux: Setting register SPI0_SDO                                                  
>> mux:    PINMUX3 (0x0000000c) = 0x155affff -> 0x175affff                         
>> mux: initialized SPI0_SDENA0                                                    
>> mux: Setting register SPI0_SDENA0                                               
>> mux:    PINMUX3 (0x0000000c) = 0x175affff -> 0x375affff                         
>> edma edma.0: Legacy memcpy is enabled, things might not work                    
>> edma edma.0: TI EDMA DMA engine driver                                          
>> 8<--- cut here ---                                                              
>> Unable to handle kernel NULL pointer dereference at virtual address 000000c0    
>> pgd = (ptrval)                                                                  
>> [000000c0] *pgd=00000000                                                        
>> Internal error: Oops: 5 [#1] PREEMPT ARM                                        
>> Modules linked in:                                                              
>> CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc1-00001-g927d10a85791-dirty #146
>> Hardware name: DaVinci DM365 EVM                                                
>> PC is at reg_fixed_voltage_probe+0x30/0x2ec                                     
>> LR is at reg_fixed_voltage_probe+0x2c/0x2ec                                     
>> pc : [<c02a9628>]    lr : [<c02a9624>]    psr: 60000053                         
>> sp : c6837de0  ip : 00000000  fp : c062cfd8                                     
>> r10: c05f44a8  r9 : 00000000  r8 : c68a24d0                                     
>> r7 : c0631008  r6 : c68a24e0  r5 : 00000000  r4 : c68a24e0                      
>> r3 : 00000000  r2 : c065a854  r1 : 00000000  r0 : 00000000                      
>> Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none              
>> Control: 0005317f  Table: 80004000  DAC: 00000053                               
>> Process swapper (pid: 1, stack limit = 0x(ptrval))                              
>> Stack: (0xc6837de0 to 0xc6838000)                                               
>> 7de0: c689be40 c0167044 00000000 c68f4720 c68f4660 c68f4660 c68f4720 c689be40   
>> 7e00: c0575ca4 64d9cb0d 00000000 c68a24e0 00000000 c065a854 c065a854 00000000   
>> 7e20: 00000000 c05f44a8 c062cfd8 c02e0a64 c68a24e0 c0688d00 00000000 c02dec54   
>> 7e40: c68a24e0 c065a854 c065a854 c0631008 ffffe000 c061e828 c05f44a8 c02def44   
>> 7e60: 00000000 ffffff08 ffff0a00 c68a24e0 00000000 c065a854 c0631008 ffffe000   
>> 7e80: c061e828 c05f44a8 c062cfd8 c02df1f8 00000000 c065a854 c68a24e0 c02df258   
>> 7ea0: c68337b0 c065a854 c02df200 c02dced4 c061e828 c681db90 c68337b0 64d9cb0d   
>> 7ec0: c062cfd8 c065a854 c682af00 c065ea48 00000000 c02de070 c054f984 c0494cc0   
>> 7ee0: c065a854 c065a854 c0631008 c060b098 00000000 c02dfb04 c066d5c0 c0631008   
>> 7f00: c060b098 c000a624 0000007f c7fffea8 c05d00c4 00000000 c7fffee9 c00372e0   
>> 7f20: c05cf6d8 c0549714 00000000 00000004 00000004 00000000 00000000 c7fffee2   
>> 7f40: c7fffee5 64d9cb0d 00000000 0000007f c061e844 64d9cb0d 0000007f c061e848   
>> 7f60: 00000005 c066d5c0 c066d5c0 c05f4e6c 00000004 00000004 00000000 c05f44a8   
>> 7f80: 00000000 00000000 c04a71bc 00000000 00000000 00000000 00000000 00000000   
>> 7fa0: 00000000 c04a71c4 00000000 c00090e0 00000000 00000000 00000000 00000000   
>> 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000   
>> 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000   
>> [<c02a9628>] (reg_fixed_voltage_probe) from [<c02e0a64>] (platform_drv_probe+0x)
>> [<c02e0a64>] (platform_drv_probe) from [<c02dec54>] (really_probe+0x1e0/0x34c)  
>> [<c02dec54>] (really_probe) from [<c02def44>] (driver_probe_device+0x5c/0x168)  
>> [<c02def44>] (driver_probe_device) from [<c02df1f8>] (device_driver_attach+0x58)
>> [<c02df1f8>] (device_driver_attach) from [<c02df258>] (__driver_attach+0x58/0xc)
>> [<c02df258>] (__driver_attach) from [<c02dced4>] (bus_for_each_dev+0x70/0xb4)   
>> [<c02dced4>] (bus_for_each_dev) from [<c02de070>] (bus_add_driver+0x194/0x1cc)  
>> [<c02de070>] (bus_add_driver) from [<c02dfb04>] (driver_register+0x74/0x108)    
>> [<c02dfb04>] (driver_register) from [<c000a624>] (do_one_initcall+0x6c/0x1d8)   
>> [<c000a624>] (do_one_initcall) from [<c05f4e6c>] (kernel_init_freeable+0x10c/0x)
>> [<c05f4e6c>] (kernel_init_freeable) from [<c04a71c4>] (kernel_init+0x8/0xec)    
>> [<c04a71c4>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)          
>> Exception stack(0xc6837fb0 to 0xc6837ff8)                                       
>> 7fa0:                                     00000000 00000000 00000000 00000000   
>> 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000   
>> 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000                     
>> Code: e5920018 e58d3024 eb02b71e e3a03000 (e59090c0)                            
>> ---[ end trace 90e87368a248f7f6 ]---                                            
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b      
> 
> Interesting.
> Something has changed in regulators core which causes crash when not
> booted with DT?
> 
> It did worked when I have sent the patches. I'll take a look what might
> be the issue.

can this be the fix: https://lkml.org/lkml/2019/9/21/199 ?

> 
> Same for the dma644x
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
