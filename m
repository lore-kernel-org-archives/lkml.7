Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D382184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZCFwsI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDEFML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:12:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38802 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEFML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:12:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3559ooU083095;
        Fri, 5 Apr 2019 05:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WeR2/whCO1W6NG5KoRYkkKwt/sBd7bV+OfdJIF37gtI=;
 b=MZCFwsI60EQI6qIFfGE/Q/dEwQGU7VLcymOCAWEX6QZhdW0qWbNRzUrVBfB9V40n4jKN
 6wSHWyk6Gri0TXhkeRsrNAsIcBxMJtsthsA0gZj0Ohftdl/BqcZpnQOQdmcvykmmJNxN
 mt1UYXneUNVrFKLLKurZyKQTnYtjbYke74lXXpA+yqxEphnur6eq+hJe5ECu5kVLwjuQ
 RctKmPaws3YNXzgea3Igm8cpkVz5jnNi9hbRI/v+a1Oe34a5GDvU6s8US0c7Lvruj+Cl
 9ll1TxNfKW1iQwYFYjHTcKgJv3jGJKklthdECD85C7cbNCvlrTuk9GWz5Wylfa3td6BF Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rhwydjvqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 05:11:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x355BNL4167406;
        Fri, 5 Apr 2019 05:11:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rm8f6ab14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 05:11:59 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x355Bu8h020577;
        Fri, 5 Apr 2019 05:11:57 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 22:11:55 -0700
Date:   Fri, 5 Apr 2019 08:11:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Caio Salvador Rohwedder <caiosalvador96@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        lkcamp@lists.libreplanetbr.org, linux-kernel@vger.kernel.org,
        johnfwhitmore@gmail.com
Subject: Re: [PATCH] staging: rtl8192u: ieee80211: add space around '==' and
 before '('
Message-ID: <20190405051147.GN32590@kadam>
References: <20190405015646.20672-1-caiosalvador96@gmail.com>
 <e595121b-81f1-8242-eb91-a9258b96831d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e595121b-81f1-8242-eb91-a9258b96831d@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050038
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:31:17AM +0800, YueHaibing wrote:
> On 2019/4/5 9:56, Caio Salvador Rohwedder wrote:
> >  			if(!list_empty(pUnusedList)) {
> >  				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
> >  				list_del_init(&(*ppTS)->list);
> > -				if(TxRxSelect==TX_DIR) {
> > +				if (TxRxSelect == TX_DIR) {
> >  					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, ts_common_info);
> 
> This line seems over 80 characters, may also be fixed.
> 

The 80 character problem isn't really related to the "space required"
problem.  Those would need to be fixed in separate patches.

> In fact, this file has so many code style issues, see
> 
> ./scripts/checkpatch.pl --no-tree -f drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
> 

Yes.  Of course it has millions of style issues.  It's staging code.
Leave it.  We'll fix it little by little.

That said, I kind of would prefer to review patches which fix all the
"space[s] required" checkpatch warnings in a file in one go...

regards,
dan carpenter
