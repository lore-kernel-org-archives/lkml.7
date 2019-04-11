Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AA220818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2KWSY/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDKPt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:49:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37048 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zwCi7Tk9UZYC4peORFWRL8HFRCqi0bSYc5cfFAQe8HE=; b=e2KWSY/x9N1ZKU2Z8JZbpAClfV
        yynl3gr94JwUFH+uU0hbZXFf++cg7RhddFPW9xSdjbmBUahlRnKj94I3vFmaUpvGeAP/xlOJdF8MM
        Hw9p6u4X7drjFsXxflwMvQcZlYkJNSrg/mXx5YUGK8R4jPsG6iZoJl4hKTodd9Wul/RYbeV+Y1zEf
        Y06fvyCHrAZpWyyvm0x17iD2EmqKJBdcbW/xdsGprcsARg9km76PqbDJC/lCvXQ2RKpYnhkQtUReI
        nCQku23u0xpQxyKPN8WjIWTHa1ECmPMCJYmLa64aa+yVFAbdtBgwklA3ouRSNQo9P6wQ9/GA2OVk1
        5fnm1kQg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEbx6-0004fx-Bi; Thu, 11 Apr 2019 15:49:24 +0000
Subject: Re: [GIT PULL] <global> global spelling corrections for v5.1.0-rc5
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Kenny Van de Maele <kenny.vandemaele@inuits.eu>,
        torvalds@linux-foundation.org
Cc:     torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <0b6539fe5b2741b1327119236ea0e401d02003e6.camel@inuits.eu>
 <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
Message-ID: <4def7caf-6726-e373-181e-4fd698ef5b53@infradead.org>
Date:   Thu, 11 Apr 2019 08:49:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 7:58 AM, Randy Dunlap wrote:
> On 4/11/19 2:12 AM, Kenny Van de Maele wrote:
>> are available in the Git repository at:
>>
>>   git://github.com/vdmkenny/linux-spelling-fix.git tags/common-
>> spelling-fixes-5.1.0-rc5
>>
>> for you to fetch changes up to
>> 6ee0055f3414a64133228e82004ea60d0e659d6d:
>>
>>   fix common spelling mistakes (2019-04-11 10:22:24 +0200)
>>
>> ----------------------------------------------------------------
>> This PR contains a set of global spelling fixes of commonly miss-
>> spelled
> 
> misspelled
> 
> 
> Is there a way for me to review the diff on github?
> 
> thanks.
> 
> 
>> words. Mostly documentation and comments were impacted, but a few lines
>> of code were affected as well.

For the changes that are in source code language instead of in comments,
did you re-compile those changes?


>> ----------------------------------------------------------------
>> Kenny Van de Maele (1):
>>       fix common spelling mistakes
> 
> 

more:

drivers/nfc/pn533/pn533.c
@@ -601,7 +601,7 @@ static int pn533_send_sync_complete(struct pn533 *dev, void *_arg,
 *     as it's been already freed at the beginning of RX path by
 *     async_complete_cb.
 *
- *  3. valid pointer in case of succesfult RX path
+ *  3. valid pointer in case of successfult RX path
 *
 *  A caller has to check a return value with IS_ERR macro. If the test pass,
 *  the returned pointer is valid.


and:

drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4768,7 +4768,7 @@ _scsih_normalize_sense(char *sense_buffer, struct sense_info *data)
}

/**
- * _scsih_scsi_ioc_info - translated non-succesfull SCSI_IO request
+ * _scsih_scsi_ioc_info - translated non-successfull SCSI_IO request
 * @ioc: per adapter object
 * @scmd: pointer to scsi command object
 * @mpi_reply: reply mf payload returned from firmware


and:

ipc/sem.c
@@ -2092,7 +2092,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
	queue.dupsop = dupsop;

	error = perform_atomic_semop(sma, &queue);
-	if (error == 0) { /* non-blocking succesfull path */
+	if (error == 0) { /* non-blocking successfull path */
		DEFINE_WAKE_Q(wake_q);

		/*


eh?:

tools/perf/util/parse-events.c
@@ -767,7 +767,7 @@ split_bpf_config_terms(struct list_head *evt_head_config,
	/*
	 * Currectly, all possible user config term
	 * belong to bpf object. parse_events__is_hardcoded_term()
-	 * happends to be a good flag.
+	 * happeneds to be a good flag.
	 *
	 * See parse_events_config_bpf() and
	 * config_term_tracepoint().



but once these changes are fixed, overall this is a good set of corrections.

-- 
~Randy
