Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4482C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E49214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mc3B9sTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfLLQcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:32:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58996 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfLLQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:32:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCGMKph142384;
        Thu, 12 Dec 2019 16:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=1Me3TBEuSHGpaj+SzUfnUPEsajZ9tscnXl2BKzzAHAo=;
 b=Mc3B9sTmqgyhNVLCEl8Z8AWM+4aWiWhZiD4hQGAJbIeXfc8Lvoj6FoHXkbvrPHLl+VkB
 +x9isSX6UYVdMNKpYqkUzXe+2/j30zglR0VKakb0u2wCyromovCgLRUIzYfGoLGTgUWS
 mwNJWqLjF9LF3yS7fb8snEk/7dvtemVwO6f1gYxNxuPkYjkYolqxSjXPxTZGqPFc2qcD
 3zAg+ve5jEZfHfUei4O6fHnn1vF49wbgWkHbAFFyov08AUf/FLGXcdDa89Fmpel514a5
 0uI3FYGkb9XPm/N+WJIhRmXGau6Tkr016LmK7SZmtLq9IrLIu03eaeTf0g6uu7o/sgki lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41qm5cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 16:31:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCGTUMO155730;
        Thu, 12 Dec 2019 16:31:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wumw0b25d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 16:31:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCGVvGw026605;
        Thu, 12 Dec 2019 16:31:57 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 08:31:56 -0800
Date:   Thu, 12 Dec 2019 19:31:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Scott Schafer <schaferjscott@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        GR-Linux-NIC-Dev@marvell.com, Manish Chopra <manishc@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/23] staging: qlge: Fix CHECK: braces {} should be
 used on all arms of this statement
Message-ID: <20191212163149.GA1873@kadam>
References: <cover.1576086080.git.schaferjscott@gmail.com>
 <0e1fc1a16725094676fdab63d3a24a986309a759.1576086080.git.schaferjscott@gmail.com>
 <20191212121206.GB1895@kadam>
 <20191212150200.GA8219@karen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212150200.GA8219@karen>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:02:00AM -0600, Scott Schafer wrote:
> On Thu, Dec 12, 2019 at 03:12:06PM +0300, Dan Carpenter wrote:
> > On Wed, Dec 11, 2019 at 12:12:40PM -0600, Scott Schafer wrote:
> > > @@ -351,8 +352,9 @@ static int ql_aen_lost(struct ql_adapter *qdev, struct mbox_params *mbcp)
> > >  	mbcp->out_count = 6;
> > >  
> > >  	status = ql_get_mb_sts(qdev, mbcp);
> > > -	if (status)
> > > +	if (status) {
> > >  		netif_err(qdev, drv, qdev->ndev, "Lost AEN broken!\n");
> > > +	}
> > >  	else {
> > 
> > The close } should be on the same line as the else.
> > 
> > >  		int i;
> > >  
> > 
> > regards,
> > dan carpenter
> 
> this was fixed in patch 22

The truth is that I don't care at all about tiny typos like this, but
in the future then the right way to fix these is to create a separate
patch for this, and the use git rebase to fold it back into this patch.
It's a pretty straight forward process.

regards,
dan carpenter
