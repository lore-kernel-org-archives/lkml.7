Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF4C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1124434
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfE3CWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:22:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfE3CWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:22:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A169309264C;
        Thu, 30 May 2019 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B63B60603;
        Thu, 30 May 2019 02:22:21 +0000 (UTC)
Subject: Re: [PATCH v2] scsi: smartpqi: properly set both the DMA mask and the
 coherent DMA mask in pqi_pci_init()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, don.brace@microsemi.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, Thomas.Lendacky@amd.com,
        dyoung@redhat.com
References: <20190527005934.1493-1-lijiang@redhat.com>
 <yq14l5czopg.fsf@oracle.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <63f06e98-df6f-35dc-da41-dc039f04511d@redhat.com>
Date:   Thu, 30 May 2019 10:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <yq14l5czopg.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 30 May 2019 02:22:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年05月30日 10:00, Martin K. Petersen 写道:
> 
> Lianbo,
> 
>> When SME is enabled, the smartpqi driver won't work on the HP DL385
>> G10 machine, which causes the failure of kernel boot because it fails
>> to allocate pqi error buffer. Please refer to the kernel log:
> 
> Applied to 5.2/scsi-fixes, thanks!
> 
OK, thank you, Martin K.

And also thanks to Tom and Don for helping review this patch.

Lianbo
