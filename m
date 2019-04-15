Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A982EC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795BD2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlcLGgbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfDOQHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:07:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60992 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfDOQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:07:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FFx3n3048996;
        Mon, 15 Apr 2019 16:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CQocKb/a4zPGWX6ubmmIrqdRqKumlc3s8liTPDXoQ+Q=;
 b=qlcLGgbuefoBr6iCx5W3Al9Q4Ps6xLQIUeiNNF4TwyyBN9I2lOlM+4nMgIelmYNeYcCk
 4554NU4gG0s4dcW1JE1v27rVE2rExW8+ahM4siDy0aTUeDRAlb9YYmU03W7h6/e+vmhf
 ClvHjzrUt6RkdGm5qqTdnqWELfAPN+dMAHndOXuRyAUWCImS9peBOWzhvPcslVbgaQEE
 OA0MfXfGaV+sPyEoqnX2w3sWrf2VHR8zRm7x0mnusCEoRyeZUamRBomY5IEguQ2vNYJ9
 wSN/wd4uTgQY3aiQibiCxfnZ+D5NtIwWFuKSc9g9VZ+essmlxMHNSI0Qh09te1Bm5mWx 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2ru59cys2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 16:06:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FG43OS079616;
        Mon, 15 Apr 2019 16:04:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rvv139j5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 16:04:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FG4n91012654;
        Mon, 15 Apr 2019 16:04:49 GMT
Received: from kadam (/41.210.147.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 09:04:48 -0700
Date:   Mon, 15 Apr 2019 19:04:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] Staging: greybus: Cleanup in header file control.h
Message-ID: <20190415160440.GQ6095@kadam>
References: <20190405201437.3689-1-madhumithabiw@gmail.com>
 <20190415131002.GC775@localhost>
 <20190415133357.GP6095@kadam>
 <20190415141201.GD775@localhost>
 <20190415144015.GB22423@kadam>
 <20190415150333.GE775@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415150333.GE775@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=845
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150111
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=885 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:33PM +0200, Johan Hovold wrote:
> But then all eight or so instances should be replaced in one go, to
> maintain consistency.

Yeah, that's fair enough, I suppose.

regards,
dan carepenter
