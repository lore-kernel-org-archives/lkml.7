Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EEC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924EE20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfHLM4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:56:40 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:12606 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbfHLM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:56:40 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CCtqUm030029;
        Mon, 12 Aug 2019 12:56:28 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ub6wj0s73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 12:56:28 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id D0472A3;
        Mon, 12 Aug 2019 12:56:26 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 7251B39;
        Mon, 12 Aug 2019 12:56:25 +0000 (UTC)
Date:   Mon, 12 Aug 2019 07:56:25 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        linux-kernel@vger.kernel.org, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: status of drivers/misc/sgi-gru?
Message-ID: <20190812125625.GA27091@hpe.com>
References: <20190812080518.GA29629@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812080518.GA29629@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=573 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the GRU driver is still maintained, and I have been in contact with Bharath
about my pending testing of his changes.

On Mon, Aug 12, 2019 at 01:05:19AM -0700, Christoph Hellwig wrote:
> Hi dear ex-SGI folks,
> 
> do you know if the GRU driver is still maintained and in use?
> 
> Both Bharath and Jason have been posting changes to it that need
> review, and I've just been discussing even more extensive mmu_notifier
> changes with Jason that will require some very careful review.  If the
> driver is still need I'd really like to hear your feedback.
