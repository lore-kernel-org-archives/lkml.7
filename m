Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A578BC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9F218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfGEHWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:22:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfGEHWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:22:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CD5BAFA9;
        Fri,  5 Jul 2019 07:22:43 +0000 (UTC)
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
 <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
 <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
 <da579578-349e-1320-0867-14fde659733e@acm.org>
 <AT5PR8401MB11695CC7286B2D2F98FB9EADABEA0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <1ad3e7ba-008d-31ad-89a0-b118b36e14e2@suse.de>
Date:   Fri, 5 Jul 2019 09:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB11695CC7286B2D2F98FB9EADABEA0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 7:43 PM, Elliott, Robert (Servers) wrote:
> 
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bart
>> Van Assche
>> Sent: Monday, June 17, 2019 10:28 PM
>> To: dgilbert@interlog.com; Marc Gonzalez <marc.w.gonzalez@free.fr>; James Bottomley
>> <jejb@linux.ibm.com>; Martin Petersen <martin.petersen@oracle.com>
>> Cc: SCSI <linux-scsi@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Christoph Hellwig
>> <hch@lst.de>
>> Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
>>
>> On 6/17/19 5:35 PM, Douglas Gilbert wrote:
>>> For sg3_utils:
>>>
>>> $ find . -name '*.c' -exec grep "/proc/scsi" {} \; -print
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sg_read.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sgp_dd.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sgm_dd.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./src/sg_dd.c
>>>                  "'echo 1 > /proc/scsi/sg/allow_dio'\n", q_len,
>>> dirio_count);
>>> ./testing/sg_tst_bidi.c
>>> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
>>> ./examples/sgq_dd.c
>>>
>>> That is 6 (not 38) by my count.
>>
>> Hi Doug,
>>
>> This is the command I ran:
>>
>> $ git grep /proc/scsi | wc -l
>> 38
>>
>> I think your query excludes scripts/rescan-scsi-bus.sh.
>>
>> Bart.
> 
> Here's the full list to ensure the discussion doesn't overlook anything:
> 
> sg3_utils-1.44$ grep -R /proc/scsi .
> ./src/sg_read.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sgp_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sgm_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sg_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./scripts/rescan-scsi-bus.sh:# Return hosts. /proc/scsi/HOSTADAPTER/? must exist
> ./scripts/rescan-scsi-bus.sh:  for driverdir in /proc/scsi/*; do
> ./scripts/rescan-scsi-bus.sh:    driver=${driverdir#/proc/scsi/}
> ./scripts/rescan-scsi-bus.sh:      name=${hostdir#/proc/scsi/*/}
> ./scripts/rescan-scsi-bus.sh:# Get /proc/scsi/scsi info for device $host:$channel:$id:$lun
> ./scripts/rescan-scsi-bus.sh:    SCSISTR=$(grep -A "$LN" -e "$grepstr" /proc/scsi/scsi)
> ./scripts/rescan-scsi-bus.sh:    DRV=`grep 'Attached drivers:' /proc/scsi/scsi 2>/dev/null`
> ./scripts/rescan-scsi-bus.sh:      echo "scsi report-devs 1" >/proc/scsi/scsi
> ./scripts/rescan-scsi-bus.sh:      DRV=`grep 'Attached drivers:' /proc/scsi/scsi 2>/dev/null`
> ./scripts/rescan-scsi-bus.sh:      echo "scsi report-devs 0" >/proc/scsi/scsi
> ./scripts/rescan-scsi-bus.sh:# Outputs description from /proc/scsi/scsi (unless arg passed)
> ./scripts/rescan-scsi-bus.sh:        echo "scsi remove-single-device $devnr" > /proc/scsi/scsi
> ./scripts/rescan-scsi-bus.sh:          echo "scsi add-single-device $devnr" > /proc/scsi/scsi
> ./scripts/rescan-scsi-bus.sh:      echo "scsi add-single-device $devnr" > /proc/scsi/scsi
> ./scripts/rescan-scsi-bus.sh:      echo "scsi add-single-device $devnr" > /proc/scsi/scsi
> ./scripts/rescan-scsi-bus.sh:      echo "scsi add-single-device $host $channel $id $SCAN_WILD_CARD" > /proc/scsi/scsi
> ./scripts/rescan-scsi-bus.sh:if test ! -d /sys/class/scsi_host/ -a ! -d /proc/scsi/; then
> ./ChangeLog:    /proc/scsi/sg/allow_dio is '0'
> ./ChangeLog:  - change sg_debug to call system("cat /proc/scsi/sg/debug");
> ./suse/sg3_utils.changes:  * Support systems without /proc/scsi
> ./examples/sgq_dd.c:static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./doc/sg_read.8:If direct IO is selected and /proc/scsi/sg/allow_dio
> ./doc/sg_read.8:"echo 1 > /proc/scsi/sg/allow_dio". An alternate way to avoid the
> ./doc/sg_map.8:observing the output of the command: "cat /proc/scsi/scsi".
> ./doc/sgp_dd.8:at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
> ./doc/sgp_dd.8:this at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
> ./doc/sgp_dd.8:mapping to SCSI block devices should be checked with 'cat /proc/scsi/scsi'
> ./doc/sg_dd.8:notes this at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
> ./doc/sg_dd.8:this at completion. If direct IO is selected and /proc/scsi/sg/allow_dio
> ./doc/sg_dd.8:with 'echo 1 > /proc/scsi/sg/allow_dio'.
> ./doc/sg_dd.8:mapping to SCSI block devices should be checked with 'cat /proc/scsi/scsi',
> 
> 
As mentioned, rescan-scsi-bus.sh is keeping references to /proc/scsi as
a fall back only, as it's meant to work kernel independent. Per default
it'll be using /sys, and will happily work without /proc/scsi.

So it's really only /proc/scsi/sg which carries some meaningful
information; maybe we should move/copy it to somewhere else.

I personally like getting rid of /proc/scsi.

Cheers,

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
