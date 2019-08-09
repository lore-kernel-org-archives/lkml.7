Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B67C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C39C214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436657AbfHISxU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:53:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:45178 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHISxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:53:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 11:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="169394150"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2019 11:53:19 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 9 Aug 2019 11:53:18 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.11]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.128]) with mapi id 14.03.0439.000;
 Fri, 9 Aug 2019 11:53:18 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "andrzej.p@collabora.com" <andrzej.p@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH V2] usb: dwc3: gadget: trb_dequeue is not updated
 properly
Thread-Topic: [PATCH V2] usb: dwc3: gadget: trb_dequeue is not updated
 properly
Thread-Index: AQHVPUaDMYdk5Cgjz0WPgMvoOhlVmqbQnM5QgAFk9oCAAG1EwIAe6UYAgAHrMJA=
Date:   Fri, 9 Aug 2019 18:53:18 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F905DB9@ORSMSX102.amr.corp.intel.com>
References: <1563396788-126034-1-git-send-email-fei.yang@intel.com>
 <87o91riux9.fsf@linux.intel.com>
 <02E7334B1630744CBDC55DA8586225837F8DD883@ORSMSX102.amr.corp.intel.com>
 <87muhascua.fsf@linux.intel.com>
 <02E7334B1630744CBDC55DA8586225837F8DE348@ORSMSX102.amr.corp.intel.com>
 <8736icnqk7.fsf@gmail.com>
In-Reply-To: <8736icnqk7.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDYxYTJmZGYtMTI1Ny00NmM5LTgwMmQtMjA1OGI0NWVkZDkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSDRtVFVkakNDd21DUjN2QXI5cGd5WUtUWVwvVllGazlaSU5cL2hNYkVTb1BUOUp3V2pBWE9lMUpuaGwyQmZSVGhOIn0=
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I need tracepoints to see what's going on, please collect tracepoints.
>>
>> See attached. Search for "length 16384/16384" to the USB request using 
>> sg list. And the transfer stalls at a request with "length 512/512".
>
> which gadget driver is this btw? Let's look at what happened leading up to this problem:
I'm using the upstream kernel with some Android patches from Google. Comparing to pure upstream, there is no change in drivers/usb/dwc3/.
There are a few Android patches on top of drivers/usb/gadget, but those don't seem to have anything to do with this case as the patches are
changing things like f_accessory/f_audio/f_midi.

>>        <...>-3107  [001] d..1   164.184431: dwc3_alloc_request: ep1out: req 0000000066963d3c length 0/0 zsI ==> 0
>
> Allocated a new request
>
>>        <...>-3107  [001] d..2   164.184432: dwc3_ep_queue: ep1out: req 0000000066963d3c length 0/16384 zsI ==> -115
>
> queued it for a 16kiB transfer (split into 3 sglist entries)
>
>>        <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 0000000011fb30b4 buf 0000000077caf000 size 4096 ctrl 0000001d (HlCS:sc:normal)
>
> first one, 4kiB. Note the capital 'C', this one is chained.
>
>>        <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 00000000bc197bc2 buf 0000000077cb0000 size 8192 ctrl 0000001d (HlCS:sc:normal)
>
>second one, 8kiB. Also chained.
>
>>        <...>-3107  [001] d..2   164.184433: dwc3_prepare_trb: ep1out: trb 00000000ae5c00ad buf 0000000077cb2000 size 4096 ctrl 00000819 (HlcS:sC:normal)
>
> last one, 4kiB. NOT CHAINED!
>
>>        <...>-3107  [001] d..2   164.184438: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>
> issue update transfer
>
>>        <...>-3107  [001] d..1   164.184444: dwc3_alloc_request: ep1out: req 00000000fe2c6e9d length 0/0 zsI ==> 0
>
> now gadget driver allocates a NEW request
>
>>        <...>-3107  [001] d..2   164.184444: dwc3_ep_queue: ep1out: req 00000000fe2c6e9d length 0/512 zsI ==> -115
>
> ... and queues it for zero bytes. Why? Why didn't gadget driver set the ZERO flag in the original request?
I don't see any difference between this request and the one above for 16Kbyte (except the length). Why are you expecting "Z" to be set?
The 0 is request.actual, which is correct at this point of time.

>>        <...>-3107  [001] d..2   164.184445: dwc3_prepare_trb: ep1out: trb 0000000055827a46 buf 0000000077cb3000 size 512 ctrl 00000819 (HlcS:sC:normal)
>
> a single TRB is prepared correctly.
> 
>>        <...>-3107  [001] d..2   164.184449: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>
> Update transfer is issued.
>
>>        <...>-3165  [001] d..1   164.192315: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
>>        <...>-3165  [001] d..1   164.192316: dwc3_complete_trb: ep1out: trb 0000000017050f80 buf 0000000077c63000 size 0 ctrl 0000001c (hlCS:sc:normal)
>>        <...>-3165  [001] d..1   164.192325: dwc3_gadget_giveback: ep1out: req 00000000af8aa80e length 16384/16384 zsI ==> 0
>> kworker/u8:5-1165  [001] ....   164.192353: dwc3_free_request: ep1out: req 00000000af8aa80e length 16384/16384 zsI ==> 0
>>        <...>-3165  [001] d..1   164.192849: dwc3_event: event (00004084): ep1out: Transfer In Progress [0] (sIm)
>>        <...>-3165  [001] d..1   164.192851: dwc3_complete_trb: ep1out: trb 00000000c1f0fd23 buf 0000000077c64000 size 0 ctrl 0000001c (hlCS:sc:normal)
>>        <...>-3165  [001] d..1   164.192860: dwc3_gadget_giveback: ep1out: req 0000000066963d3c length 16384/16384 zsI ==> 0
>
> here we giveback the request to the gadget driver. Note that the TRB addresses that were completed do NOT match the TRB addresses of the prepared TRBs.
> Again, which gadget driver is this? Where is the source code for this gadget driver? Also note that we requested for event upon completion of the final TRB only
> but we get events for each and every TRB.

I don't know how to interpret this trace log, but it didn't help me find the problem until I added my own log in the prepare_trb() and completed_trb()
[   86.817218] ffs_epfile_io:READ:SG: buf=00000000fcc78b10 sg=00000000952c5428 length=16384 num_sgs=4
[   86.827242]  __dwc3_prepare_one_trb: size=4096 bp=000000007780d000 ctrl=0000001d enq=b3
[   86.836172]  __dwc3_prepare_one_trb: size=4096 bp=000000007780e000 ctrl=0000001d enq=b4
[   86.845100]  __dwc3_prepare_one_trb: size=4096 bp=000000007780f000 ctrl=0000001d enq=b5
[   86.854028]  __dwc3_prepare_one_trb: size=4096 bp=0000000077810000 ctrl=00000819 enq=b6
[   86.862959] __dwc3_gadget_kick_transfer: updating buf=00000000be7c4a4c sg=00000000952c5428 length=16384 pending_sgs=4 remaining=0
[   86.876146] ffs_epfile_io:READ:SG: buf=000000008b573d0c sg=00000000d7992341 length=16384 num_sgs=4
[   86.886159]  __dwc3_prepare_one_trb: size=4096 bp=0000000077811000 ctrl=0000001d enq=b7
[   86.895091]  __dwc3_prepare_one_trb: size=4096 bp=0000000077812000 ctrl=0000001d enq=b8
[   86.904023]  __dwc3_prepare_one_trb: size=4096 bp=0000000077813000 ctrl=0000001d enq=b9
[   86.912955]  __dwc3_prepare_one_trb: size=4096 bp=0000000077814000 ctrl=00000819 enq=ba
[   86.921890] __dwc3_gadget_kick_transfer: updating buf=00000000be7c4a4c sg=00000000952c5428 length=16384 pending_sgs=4 remaining=0
[   86.934979] dwc3_gadget_ep_reclaim_completed_trb(1): buf=00000000be7c4a4c sg=00000000952c5428 status=0 ctrl=0000001c length=16384 pending_sgs=3 trb_size=0 evstatus=00000004
[   86.936025] ffs_epfile_io:READ:SG: buf=000000006cee33d6 sg=00000000244e9645 length=16384 num_sgs=4
[   86.952253] dwc3_gadget_ep_reclaim_completed_trb(1): buf=00000000be7c4a4c sg=00000000d7992341 status=0 ctrl=0000001c length=16384 pending_sgs=3 trb_size=0 evstatus=00000004

From this log, you can clearly see each sg list gets only one reclaim_completed_trb() call, and the trb reclaimed is not the last one (ctrl=0000001c, the last one should have ctrl=00000818).
The trb addresses is continuous as indicated by bp=000000007780d000 to bp=0000000077814000 with 4K increment in between.
Also you can see that event->status has IOC bit set (evstatus=00000004), so the for-loop to reclaim all trb in the sg list breaks out right after the first trb is reclaimed.


