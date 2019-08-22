Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E76DC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE4020870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfHVHEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:04:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728497AbfHVHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:04:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7M72MP9034530
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:04:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhkernmwp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:04:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Thu, 22 Aug 2019 08:04:08 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 08:04:02 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7M741qN36765866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 07:04:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4703311C054;
        Thu, 22 Aug 2019 07:04:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B72E211C04A;
        Thu, 22 Aug 2019 07:03:57 +0000 (GMT)
Received: from oc3276512013.ibm.com (unknown [9.120.237.31])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 07:03:57 +0000 (GMT)
Subject: Re: [PATCH V1]Perf: Return error code for perf_session__new function
 on failure
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, jeremie.galarneau@efficios.com,
        shawn@git.icu, tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
References: <20190820105645.4920.55590.stgit@localhost.localdomain>
 <20190821070540.GA16609@krava>
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Date:   Thu, 22 Aug 2019 12:33:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821070540.GA16609@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19082207-4275-0000-0000-0000035BC368
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082207-4276-0000-0000-0000386DE870
Message-Id: <8e974fb4-c4e0-b1f3-0770-d5b9eafc8da3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/08/19 12:35 PM, Jiri Olsa wrote:
> On Tue, Aug 20, 2019 at 04:51:21PM +0530, Mamatha Inamdar wrote:
>
> SNIP
>
>>   #ifdef HAVE_ZSTD_SUPPORT
>>   static int perf_session__process_compressed_event(struct perf_session *session,
>> @@ -183,6 +184,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>>   struct perf_session *perf_session__new(struct perf_data *data,
>>   				       bool repipe, struct perf_tool *tool)
>>   {
>> +	int ret = -ENOMEM;
>>   	struct perf_session *session = zalloc(sizeof(*session));
>>   
>>   	if (!session)
>> @@ -197,13 +199,15 @@ struct perf_session *perf_session__new(struct perf_data *data,
>>   
>>   	perf_env__init(&session->header.env);
>>   	if (data) {
>> -		if (perf_data__open(data))
>> +		ret = perf_data__open(data);
>> +		if (ret < 0)
>>   			goto out_delete;
>>   
>>   		session->data = data;
>>   
>>   		if (perf_data__is_read(data)) {
>> -			if (perf_session__open(session) < 0)
>> +			ret = perf_session__open(session);
>> +			if (ret < 0)
>>   				goto out_delete;
>>   
>>   			/*
>> @@ -218,7 +222,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
>>   			perf_evlist__init_trace_event_sample_raw(session->evlist);
>>   
>>   			/* Open the directory data. */
>> -			if (data->is_dir && perf_data__open_dir(data))
>> +			ret = data->is_dir && perf_data__open_dir(data);
>> +			if (ret)
>>   				goto out_delete;
> will this return 1 in case of error?
>
> jirka

ok, I think your point is correct,

"ret" contains value of conditional statement(&&), which is always 
either 0 or 1

will do following changes and send new version of patch

if (data->is_dir) {
        ret = perf_data__open_dir(data);
        if (ret)
                goto out_delete;
}

>>   		}
>>   	} else  {
>> @@ -252,7 +257,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
>>    out_delete:
>>   	perf_session__delete(session);
>>    out:
>> -	return NULL;
>> +	return ERR_PTR(ret);
>>   }
>>   
>>   static void perf_session__delete_threads(struct perf_session *session)
>>

